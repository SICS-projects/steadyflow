/*
    PreferencesDialog.vala
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

public class PreferencesDialog : GtkBuilderDialog {
	private Map<CheckButton, string> checkbutton_map;
	private Map<RadioButton, IDownloadFile.FinishAction> finish_action_map;
	private FileChooserButton default_folder;
	private CheckButton c_show_indicator;
	private CheckButton c_show_notifications;
	private CheckButton c_minimize_to_indicator;
	private CheckButton c_start_minimized;

	public PreferencesDialog (Window parent) {
		base ("PreferencesDialog", parent, true);
		
		set_title (_("Steadyflow Preferences"));
		set_border_width (5);
		set_resizable (false);
		(get_content_area () as Box).set_spacing (2);
		
		default_folder = (FileChooserButton) get_object ("default_folder");
		
		checkbutton_map = new HashMap<CheckButton, string> ();
		checkbutton_map.set (c_show_indicator = (CheckButton) get_object ("c_show_indicator"), "show-indicator");
		checkbutton_map.set (c_show_notifications = (CheckButton) get_object ("c_show_notifications"),
			"show-notifications");
		checkbutton_map.set (c_minimize_to_indicator = (CheckButton) get_object ("c_minimize_to_indicator"),
			"minimize-to-indicator");
		checkbutton_map.set (c_start_minimized = (CheckButton) get_object ("c_start_minimized"), "start-minimized");
		
		finish_action_map = new HashMap<RadioButton, IDownloadFile.FinishAction> ();
		load_settings ();
		add_button (Stock.CLOSE, ResponseType.CLOSE);
		autoconnect ();
	}
	
	private void load_settings () {
		default_folder.set_current_folder (Services.get_default_download_folder());
		
		foreach (CheckButton cb in checkbutton_map.keys) {
			cb.active = Services.settings.get_boolean (checkbutton_map.get (cb));
		}
		
		on_show_indicator_toggled (c_show_indicator);
		
		register_finish_action ((RadioButton) get_object ("r_donothing"), IDownloadFile.FinishAction.DO_NOTHING);
		register_finish_action ((RadioButton) get_object ("r_openfile"), IDownloadFile.FinishAction.OPEN_FILE);
		register_finish_action ((RadioButton) get_object ("r_openfolder"), IDownloadFile.FinishAction.OPEN_FOLDER);
	}
	
	private void register_finish_action (RadioButton button, IDownloadFile.FinishAction action) {
		finish_action_map.set (button, action);
		
		if (Services.settings.get_enum ("default-post-download-action") == (int) action)
			button.active = true;
	}
	
	[CCode (instance_pos = -1)]
	protected void on_default_folder_changed (FileChooserButton sender) {
		Services.settings.set_string ("default-download-folder", sender.get_current_folder ());
	}
	
	[CCode (instance_pos = -1)]
	protected void on_checkbox_toggled (CheckButton sender) {
		Services.settings.set_boolean (checkbutton_map.get (sender), sender.active);
	}
	
	[CCode (instance_pos = -1)]
	protected void on_finish_action_toggled (RadioButton sender) {
		Services.settings.set_enum ("default-post-download-action", (int) finish_action_map.get (sender));
	}
	
	[CCode (instance_pos = -1)]
	protected void on_show_indicator_toggled (CheckButton sender) {
		bool active = sender.active;
	
		Services.settings.set_boolean ("show-indicator", active);
		c_minimize_to_indicator.set_sensitive (active);
		c_start_minimized.set_sensitive (active);
	}
}

}
