/*
    DownloadCellRenderer.vala
    Copyright (C) 2010 Maia Kozheva <sikon@ubuntu.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

using Gee;
using Gtk;
using Cairo;
using Steadyflow.Core;

namespace Steadyflow.UI {

public class DownloadCellRenderer : CellRenderer {
	private static const int PADDING = 4;
	private static const int ICON_SIZE = 32;

	private IDownloadFile _file;
	private CellRendererPixbuf icon_renderer;
	private CellRendererText text_over_renderer;
	private CellRendererText text_under_renderer;
	private CellRendererProgress progress_renderer;
	private Timer timer;
	private Map<string, Gdk.Pixbuf> pirates_treasure; // blame Alice :)

	public IDownloadFile file {
		get { return _file; }
		set {
			_file = value;
			
			if (_file.size == 0) {
				if (_file.status != IDownloadFile.Status.DOWNLOADING)
					progress_renderer.pulse = -1;
				else {
					progress_renderer.pulse = (int) ((uint) (timer.elapsed (null) * 5)) % 100000 + 1;
				}
				
				progress_renderer.value = _file.status == IDownloadFile.Status.FINISHED ? 100 : 0;
				progress_renderer.text = _("%s downloaded").printf (format_file_size (_file.downloaded_size));
			} else {
				progress_renderer.pulse = -1;
				int progress = (int) ((double) _file.downloaded_size / _file.size * 100);
				progress_renderer.value = progress;
				progress_renderer.text = (_("%s of %s downloaded") + " (%d%%)").printf (
					format_file_size (_file.downloaded_size), format_file_size (_file.size), progress);
			}
			
			text_over_renderer.markup = Markup.printf_escaped ("<span weight='bold' size='larger'>%s</span>",
				_file.local_basename);
			
			switch (_file.status) {
			case IDownloadFile.Status.DOWNLOADING:
				string time_str = get_time_remaining(_file.size, _file.downloaded_size, _file.speed);
				text_under_renderer.text = _("Downloading at speed %s/s").printf (
					format_file_size (_file.speed)) + " (%s)".printf (time_str);
				break;
			case IDownloadFile.Status.CONNECTING:
				text_under_renderer.text = _("Connecting...");
				break;
			case IDownloadFile.Status.PAUSED:
				text_under_renderer.text = _("Download paused");
				break;
			case IDownloadFile.Status.FINISHED:
				text_under_renderer.text = _("Download finished");
				break;
			case IDownloadFile.Status.NETWORK_ERROR:
				string text = _("Download stopped: network error");
				
				if (_file.error != null)
					text += " (%s)".printf (_file.error.message);
				
				text_under_renderer.text = text;
				break;
			}
			
			icon_renderer.pixbuf = get_pixbuf (_file.icon_name);
		}
	}
	
	private Gdk.Pixbuf? get_pixbuf (string icon_name) {
		Gdk.Pixbuf pixbuf = null;
		
		if (icon_name == null)
			return null;
		
		if (pirates_treasure.has_key (icon_name))
			return pirates_treasure.get (icon_name);
		
		try {
			pixbuf = IconTheme.get_default ().load_icon (icon_name, ICON_SIZE, 0);
		} catch (Error e) {
			try {
				pixbuf = IconTheme.get_default ().load_icon (Stock.FILE, ICON_SIZE, 0);
			} catch (Error e) {
				pixbuf = null;
			}
		}
		
		pirates_treasure.set (icon_name, pixbuf);
		return pixbuf;
	}
	
	public DownloadCellRenderer () {
		pirates_treasure = new HashMap<string, Gdk.Pixbuf> ();
		icon_renderer = new CellRendererPixbuf ();
		text_over_renderer = new CellRendererText ();
		text_under_renderer = new CellRendererText ();
		progress_renderer = new CellRendererProgress ();
		timer = new Timer ();
		timer.start ();
	}
	
	public override void get_size (Widget widget, Gdk.Rectangle? cell_area, out int x_offset, out int y_offset,
			out int width, out int height) {
		int textheight_over;
		int textheight_under;
		
		text_over_renderer.get_size (widget, null, null, null, null, out textheight_over);
		text_under_renderer.get_size (widget, null, null, null, null, out textheight_under);
		progress_renderer.get_size (widget, cell_area, out x_offset, out y_offset, out width, out height);
		height = 2 * PADDING + textheight_over + height + textheight_under;
	}
	
	public override void render (Context cr, Widget widget, Gdk.Rectangle background_area, Gdk.Rectangle cell,
			CellRendererState flags) {
		int textheight_over;
		int textheight_under;
		int progressheight;
		int x = cell.x + 2 * PADDING + ICON_SIZE;
		int y = cell.y + PADDING;
		int width = cell.width - x - PADDING;
		
		text_over_renderer.get_size (widget, null, null, null, null, out textheight_over);
		text_under_renderer.get_size (widget, null, null, null, null, out textheight_under);
		progress_renderer.get_size (widget, null, null, null, null, out progressheight);
		
		Gdk.Rectangle icon_rect = Gdk.Rectangle ()
			{ x = cell.x + PADDING, y = cell.y + (cell.height - ICON_SIZE) / 2, width = ICON_SIZE, height = ICON_SIZE };
		Gdk.Rectangle text_over_rect = Gdk.Rectangle () { x = x, y = y, width = width, height = textheight_over };
		Gdk.Rectangle progress_rect = Gdk.Rectangle ()
			{ x = x, y = y + text_over_rect.height, width = width, height = progressheight };
		Gdk.Rectangle text_under_rect = Gdk.Rectangle ()
			{ x = x, y = progress_rect.y + progress_rect.height, width = width, height = textheight_under };
		
		icon_renderer.render (cr, widget, icon_rect, icon_rect, flags);
		text_over_renderer.render (cr, widget, text_over_rect, text_over_rect, flags);
		progress_renderer.render (cr, widget, progress_rect, progress_rect, flags);
		text_under_renderer.render (cr, widget, text_under_rect, text_under_rect, flags);
	}

	// Estimate remaining time to completion
	private string get_time_remaining(int64 file_size, int64 downloaded_size, int64 speed) {
		if (speed <= 0) {
			return _("unknown time remaining");
		}
		
		if (file_size <= downloaded_size) {
			// file_size is 0 for small downloads
			return _("a few seconds remaining");
		}

		int64 size_remaining = file_size - downloaded_size;
		int64 seconds = size_remaining / speed;
		
		if (seconds < 60) {
			return ngettext ("%d second remaining", "%d seconds remaining", (int) seconds).printf((int) seconds);
		}
		
		int64 minutes = seconds / 60;

		if (minutes < 60) {
			return ngettext ("%d minute remaining", "%d minutes remaining", (int) minutes).printf((int) minutes);
		}
		
		int64 hours = minutes / 60;
		minutes = minutes % 60;

		if (hours < 24) {
			return ngettext ("%s, %d minute remaining", "%s, %d minutes remaining", (int) minutes).printf(
				ngettext ("%d hour", "%d hours", (int) hours).printf((int) hours), (int) minutes);
		}
		
		int64 days = hours / 24;
		hours = hours % 24;
		
		return ngettext ("%s, %d hour remaining", "%s, %d hour remaining", (int) hours).printf(
			ngettext ("%d day", "%d days", (int) days).printf((int) days), (int) hours);
	}
	
	private string format_file_size (uint64 size)
	{
		// Format using binary units (KiB, MiB etc.)
		return format_size (size, FormatSizeFlags.IEC_UNITS);
	}
}

}
