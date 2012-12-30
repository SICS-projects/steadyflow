/*
    AddFileDialog.vala
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
using Steadyflow.UI;

namespace Steadyflow {

public class AddFileDialog : GtkBuilderDialog {
	private Widget custom_command_area;
	private Entry url_entry;
	private Entry local_name;
	private Entry custom_command;
	private CheckButton append_filename;
	private FileChooserButton save_to;
	private ComboBox finished_action;

	public AddFileDialog (string url) {
		base ("AddFileDialog", null, false);
		
		set_title (_("Add File for Download"));
		set_resizable (true);
		set_border_width (5);
		
		Box vbox = (Box) get_content_area ();
		vbox.set_border_width (5);
		vbox.set_spacing (8);
		
		url_entry = (Entry) get_object ("url_entry");
		local_name = (Entry) get_object ("local_name");
		save_to = (FileChooserButton) get_object ("save_to");
		save_to.set_current_folder (Services.get_default_download_folder());
		
		finished_action = (ComboBox) get_object ("finished_action");
		CellRendererText renderer = new CellRendererText ();
		finished_action.pack_start (renderer, true);
		finished_action.add_attribute (renderer, "text", 0);
		finished_action.active = Services.settings.get_enum ("default-post-download-action");
		
		custom_command_area = (Widget) get_object ("custom_command_area");
		custom_command = (Entry) get_object ("custom_command");
		append_filename = (CheckButton) get_object ("append_filename");
		
		UIUtil.install_clear_handler (url_entry);
		UIUtil.install_clear_handler (local_name);
		
		response.connect (on_dialog_response);
		
		add_button (Stock.CANCEL, ResponseType.CANCEL);
		add_button (Stock.ADD, ResponseType.OK);
		set_default_response (ResponseType.OK);
		autoconnect ();

		url_entry.text = url;
		
		if (url == "") {
			Clipboard.get (Gdk.SELECTION_CLIPBOARD).request_text ((clipboard, cbtext) => {
				string text = cbtext.strip ();
				
				if (Util.is_valid_url (text)) {
					url_entry.text = text;
				}
			});
		}
	}
	
	public string get_url () {
		return url_entry.text;
	}
	
	public string get_local_name () {
		return local_name.text;
	}
	
	public string? get_save_path () {
		if (local_name.text == "") {
			return null;
		}
		
		try {
			return save_to.get_current_folder_file ().get_child_for_display_name (local_name.text).get_path ();
		} catch (Error e) {
			return null;
		}
	}
	
	public IDownloadFile.FinishAction get_finish_action () {
		return (IDownloadFile.FinishAction) finished_action.active;
	}
	
	public string? get_finish_command () {
		if (get_finish_action () != IDownloadFile.FinishAction.RUN_COMMAND) {
			return null;
		}
		
		string command = custom_command.text.strip ();
		
		if (command == "") {
			return null;
		}
		
		if (append_filename.active) {
			string? save_path = get_save_path ();
			
			if (save_path != null) {
				command += " " + Shell.quote (save_path);
			}
		}
		
		return command;
	}
	
	[CCode (instance_pos = -1)]
	protected void on_url_changed (Entry sender) {
		// Trim whitespace
		string text = sender.text.strip ();
		
		if (sender.text != text) {
			sender.text = text;
		}
		
		File file = File.new_for_uri (text);
		string? basename = file.get_basename ();
		
		if (basename != null) {
			local_name.text = basename;
		}
	}

	[CCode (instance_pos = -1)]
	protected void on_finished_action_changed (ComboBox sender) {
		if (get_finish_action () == IDownloadFile.FinishAction.RUN_COMMAND) {
			custom_command_area.show ();
		} else if (custom_command_area.visible) {
			Allocation alloc;
			custom_command_area.get_allocation (out alloc);
		
			int height = alloc.height;
			custom_command_area.hide ();
			get_allocation (out alloc);
			resize (alloc.width, alloc.height - height - 6);
		}
	}
	
	private void on_dialog_response (int response_id) {
		if (response_id == (int) ResponseType.OK) {
			file_add_request ();
		} else {
			destroy ();
		}
	}
	
	public signal void file_add_request ();
}

}
