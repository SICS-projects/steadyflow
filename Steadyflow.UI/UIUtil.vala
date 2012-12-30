/*
    UIUtil.vala
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

using Gtk;
using Steadyflow.Core;

namespace Steadyflow.UI {

public class UIUtil : GLib.Object {
	private UIUtil () {}
	
	public static const string MESSAGE_FORMAT = "<span weight='bold' size='larger'>%s</span>\n\n%s\n";
	
	public static void open_file (IDownloadFile file) {
		File gfile = File.new_for_path (file.local_name);
		
		try {
			Gtk.show_uri (Gdk.Screen.get_default (), gfile.get_uri (), Gdk.CURRENT_TIME);
		} catch (Error e) {
			stderr.printf ("Could not execute post-download action\n");
		}
	}
	
	public static void open_folder (IDownloadFile file) {
		File gfile = File.new_for_path (file.local_name);
		
		try {
			Gtk.show_uri (Gdk.Screen.get_default (), gfile.get_parent ().get_uri (), Gdk.CURRENT_TIME);
		} catch (Error e) {
			stderr.printf ("Could not execute post-download action\n");
		}
	}
	
	public static void install_clear_handler (Entry entry) {
		entry.changed.connect(() => {
			if (entry.text == "") {
				entry.secondary_icon_name = null;
			} else {
				entry.secondary_icon_activatable = true;
				entry.secondary_icon_tooltip_text = _("Clear");
				
				if (IconTheme.get_default ().has_icon ("edit-clear-symbolic")) {
					entry.secondary_icon_name = "edit-clear-symbolic";
				} else {
					entry.secondary_icon_stock = Stock.CLEAR;
				}
			}
		});
		
		entry.icon_press.connect((position, event) => {
			if (position == EntryIconPosition.SECONDARY) {
				entry.text = "";
			}
		});
	}
}

}
