/*
    FileListController.vala
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
using Steadyflow.Core;
using Steadyflow.UI;

namespace Steadyflow {

public class FileListController : GLib.Object {
	private static const double REDRAW_SEC = 0.2;

	private TreeView tree;
	private ListStore model;
	private string filter = "";
	private Timer redraw_timer;

	public FileListController (TreeView tree) {
		this.tree = tree;
		tree.get_selection ().set_mode (SelectionMode.MULTIPLE);
		
		redraw_timer = new Timer ();
		redraw_timer.start ();
		
		TreeViewColumn column = new TreeViewColumn ();
		column.expand = true;
		column.clickable = false;
		
		CellRenderer renderer = new DownloadCellRenderer();
		column.pack_start (renderer, true);
		column.set_cell_data_func (renderer, set_cell_data);
		
		model = new ListStore.newv ({ typeof (IDownloadFile) });
		tree.set_model (model);
		tree.append_column (column);
		
		foreach (IDownloadFile file in Services.download.files) {
			connect_file_signals (file);
		}
		
		update_model ();
		Services.download.file_added.connect ((file) => {
			connect_file_signals (file);
			update_model ();
		});
		Services.download.file_removed.connect ((file) => { update_model (); });
		tree.get_selection ().changed.connect (() => { selection_changed (); });
	}
	
	private IDownloadFile file_from_iter (TreeIter iter) {
		Value value;
		model.get_value (iter, 0, out value);
		return (IDownloadFile) value.get_object();
	}
	
	private void set_cell_data (CellLayout cell_layout, CellRenderer renderer, TreeModel model, TreeIter iter) {
		(renderer as DownloadCellRenderer).file = file_from_iter (iter);
	}
	
	private void connect_file_signals (IDownloadFile file) {
		file.status_changed.connect ((status) => {
			selection_changed ();
			filelist_changed ();
			tree.queue_draw ();
		});
		file.download_progressed.connect ((size) => { on_progress_notify (); });
		file.get_mount_operation.connect (set_mount_operation);
	}
	
	private void set_mount_operation (out GLib.MountOperation mount_op) {
		mount_op = new Gtk.MountOperation (null);
	}
	
	private void update_model () {
		model.clear ();
		
		foreach (IDownloadFile file in Services.download.files) {
			if (!file.local_basename.casefold ().contains (filter))
				continue;
		
			TreeIter iter;
			model.prepend (out iter);
			model.set (iter, 0, file, -1);
		}
		
		filelist_changed ();
	}
	
	private void on_progress_notify () {
		if (!tree.get_toplevel ().visible)
			return;
		
		if (redraw_timer.elapsed () >= REDRAW_SEC) {
			redraw_timer.start ();
			tree.queue_draw ();
		}
	}
	
	public int get_selection_count () {
		return tree.get_selection ().count_selected_rows ();
	}

	public IDownloadFile? get_selected_file () {
		if (get_selection_count () != 1) {
			return null;
		}
		
		TreePath path;
		TreeIter iter;
		tree.get_cursor (out path, null);
		
		if (path == null) {
			return null;
		}
		
		if (model.get_iter (out iter, path)) {
			return file_from_iter (iter);
		} else {
			return null;
		}
	}
	
	public Gee.List<IDownloadFile> get_selected_files () {
		var list = new ArrayList<IDownloadFile> ();
		
		foreach (TreePath path in tree.get_selection ().get_selected_rows (null)) {
			TreeIter iter;
			
			if (model.get_iter (out iter, path)) {
				list.add (file_from_iter (iter));
			}
		}
		
		return list;
	}
	
	public IDownloadFile? get_file_at_widget_pos (int x, int y) {
		int bx;
		int by;
		
		tree.convert_widget_to_bin_window_coords (x, y, out bx, out by);
		
		TreePath path;
		TreeIter iter;
		
		if (tree.get_path_at_pos (bx, by, out path, null, null, null)) {
			if (model.get_iter (out iter, path)) {
				return file_from_iter (iter);
			}
		}
		
		return null;
	}
	
	public void set_filter (string filter) {
		this.filter = filter.casefold ();
		update_model ();
	}
	
	internal void on_file_add_request (AddFileDialog dlg) {
		string? save_to = null;
		
		if (dlg.get_finish_action () == IDownloadFile.FinishAction.RUN_COMMAND &&
				dlg.get_finish_command () == null) {
			MessageDialog md = new MessageDialog.with_markup (dlg, DialogFlags.MODAL, MessageType.WARNING,
				ButtonsType.CLOSE, UIUtil.MESSAGE_FORMAT, _("Please enter a command to run"),
				_("You have specified that Steadyflow should run a command when the download finishes, " +
				"but have not entered a command to run. Please specify it."));
			
			md.run ();
			md.destroy ();
			return;
		}
		
		save_to = dlg.get_save_path ();
		
		if (save_to == null) {
			MessageDialog md = new MessageDialog.with_markup (dlg, DialogFlags.MODAL, MessageType.WARNING,
				ButtonsType.CLOSE, UIUtil.MESSAGE_FORMAT, _("Invalid file name"),
				_("The file name you have entered is not valid. Please correct it."));
			
			md.run ();
			md.destroy ();
			return;
		}
		
		string url = dlg.get_url ();
		
		foreach (var file in Services.download.files) {
			if (file.url == url) {
				MessageDialog md = new MessageDialog.with_markup (dlg, DialogFlags.MODAL, MessageType.ERROR,
					ButtonsType.OK, UIUtil.MESSAGE_FORMAT, _("File already in list"),
					_("The address you are trying to add for download is already in the file list."));
				
				md.run ();
				md.destroy ();
				return;
			}
		}
		
		if (File.new_for_path (save_to).query_exists (null)) {
			// Now check if already have this file somewhere
			
			MessageDialog md = new MessageDialog.with_markup (dlg, DialogFlags.MODAL, MessageType.WARNING,
				ButtonsType.NONE, UIUtil.MESSAGE_FORMAT, _("File exists"),
				_("The file you are trying to save the download to already exists. " +
				"Are you sure you want to overwrite it?"));
			
			md.add_button (Stock.CANCEL, ResponseType.CANCEL);
			md.add_button (_("Overwrite"), ResponseType.OK);
			int response = md.run ();
			md.destroy ();
			
			if (response != ResponseType.OK) {
				return;
			}
		}
	
		IDownloadFile.FinishAction finish_action = dlg.get_finish_action ();
		string? finish_command = dlg.get_finish_command ();
		dlg.destroy ();
	
		try {
			Services.download.add_file (url, save_to, finish_action, finish_command);
		} catch (Error e) {
			MessageDialog md = new MessageDialog.with_markup (null, 0, MessageType.ERROR,
				ButtonsType.CLOSE, UIUtil.MESSAGE_FORMAT, _("Error adding download"),
				_("An error has occurred while trying to start the download.") + "\n\n" + e.message);
			
			md.run ();
			md.destroy ();
		}
	}
	
	public signal void filelist_changed ();
	public signal void selection_changed ();
}

}
