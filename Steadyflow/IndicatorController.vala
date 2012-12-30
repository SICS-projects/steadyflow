/*
    IndicatorController.vala
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

namespace Steadyflow {

private const string INDICATOR_MENU = """
<ui>
	<popup name="IndicatorMenu">
		<menuitem action="ShowHide" />
		<menuitem action="Add" />
		<separator />
		<placeholder name="ItemMenus" />
		<separator />
		<menuitem action="PauseAll" />
		<menuitem action="ResumeAll" />
		<separator />
		<menuitem action="Quit" />
	</popup>
</ui>
""";

private const string INSERT_TEMPLATE = """
<ui>
	<popup name="IndicatorMenu">
		<placeholder name="ItemMenus">%s</placeholder>
	</popup>
</ui>
""";

public class IndicatorController : GLib.Object {
	private static const int MAX_FILE_MENU_ENTRIES = 6;
	
	private static string stock_quit_label;
	
	static construct {
		StockItem item;
		Stock.lookup (Stock.QUIT, out item);
		stock_quit_label = item.label;
	}

	private Gtk.ActionEntry[] actions = {
		Gtk.ActionEntry () { name = "Add", stock_id = "list-add", label = _("_Add download...") },
		Gtk.ActionEntry () { name = "Quit", stock_id = "system-shutdown", label = stock_quit_label },
		Gtk.ActionEntry () { name = "PauseAll", stock_id = "media-playback-pause", label = _("_Pause all") },
		Gtk.ActionEntry () { name = "ResumeAll", stock_id = "media-playback-start", label = _("_Resume all") }
	};
	
	private ToggleActionEntry[] toggle_actions = {
		ToggleActionEntry () { name = "ShowHide", label = _("Show download manager") }
	};
	
	private UIManager ui_manager;
	private Gtk.Menu menu;
	private ToggleAction show_hide_action;
	private Gtk.Action pause_all_action;
	private Gtk.Action resume_all_action;
	private Gtk.ActionGroup? merged_action_group = null;
	private uint merge_id = 0;
	
	public IndicatorController() {
		ui_manager = new UIManager ();
		Gtk.ActionGroup action_group = new Gtk.ActionGroup ("main");
		action_group.add_actions (actions, null);
		action_group.add_toggle_actions (toggle_actions, null);
		ui_manager.insert_action_group (action_group, 0);
		
		try {
			ui_manager.add_ui_from_string (INDICATOR_MENU, INDICATOR_MENU.length);
		} catch (Error e) {
			Util.fatal_error (e);
		}
		
		menu = (Gtk.Menu) ui_manager.get_widget ("/ui/IndicatorMenu");
		Services.indicator.set_menu (menu);
		Services.indicator.visible = Services.settings.get_boolean ("show-indicator");

		Services.settings.changed["show-indicator"].connect (() => {
			Services.indicator.visible = Services.settings.get_boolean ("show-indicator");
		});
		
		show_hide_action = (ToggleAction) action_group.get_action ("ShowHide");
		show_hide_action.active = !Services.settings.get_boolean ("start-minimized");
		show_hide_action.toggled.connect (() => { show_hide_toggled (show_hide_action.active); });
		
		// If the indicator supports left-click, use that as the show-hide command too.
		Services.indicator.clicked.connect (() => { set_main_window_visible(!show_hide_action.active); });
		
		action_group.get_action ("Add").activate.connect (() => { add_download_clicked (); });
		action_group.get_action ("Quit").activate.connect (() => { quit_clicked (); });
		
		pause_all_action = (Gtk.Action) action_group.get_action ("PauseAll");
		pause_all_action.sensitive = false;
		pause_all_action.activate.connect (pause_all);
		resume_all_action = (Gtk.Action) action_group.get_action ("ResumeAll");
		resume_all_action.sensitive = false;
		resume_all_action.activate.connect (resume_all);
		
		foreach (var file in Services.download.files) {
			connect_file_signals (file);
		}
		
		Services.download.file_added.connect ((file) => {
			connect_file_signals (file);
			update_file_menus ();
		});
		Services.download.file_removed.connect ((file) => { update_file_menus (); });
		update_file_menus ();
	}
	
	public void set_main_window_visible (bool visible) {
		show_hide_action.active = visible;
		Services.indicator.set_menu (menu);
	}
	
	private void connect_file_signals (IDownloadFile file) {
		file.status_changed.connect ((old_status) => { update_file_menus(); });
	}
	
	private void update_file_menus () {
		bool enable_pause_all = false;
		bool enable_resume_all = false;
		var files_for_menu = new ArrayList<IDownloadFile> ();
		
		foreach (var file in Services.download.files) {
			if (file.can_pause ()) {
				enable_pause_all = true;
			}
			
			if (file.can_start ()) {
				enable_resume_all = true;
			}
			
			if (files_for_menu.size < MAX_FILE_MENU_ENTRIES && (file.can_start () || file.can_pause ())) {
				files_for_menu.add (file);
			}
		}
		
		pause_all_action.sensitive = enable_pause_all;
		resume_all_action.sensitive = enable_resume_all;
		
		// Update item menus
		
		if (merged_action_group != null) {
			ui_manager.remove_action_group (merged_action_group);
		}
		
		if (merge_id != 0) {
			ui_manager.remove_ui (merge_id);
		}
		
		if (files_for_menu.size == 0) {
			merged_action_group = null;
			merge_id = 0;
		} else {
			merged_action_group = new Gtk.ActionGroup ("fileitems");
			StringBuilder new_items = new StringBuilder ();
			
			foreach (var file in files_for_menu) {
				string action_name = "FileAction%d".printf (file.uid);
				string file_label = file.local_basename.replace ("_", "__"); // Cute emoticons!
				new_items.append ("<menuitem action='%s' />".printf (action_name));

				Gtk.Action action;
				
				if (file.can_start ()) {
					action = new Gtk.Action (action_name, _("Start %s").printf (file_label), null, null);
					action.icon_name = "media-playback-start";
					action.activate.connect (() => { file.start (); });
				} else {
					action = new Gtk.Action (action_name, _("Pause %s").printf (file_label), null, null);
					action.icon_name = "media-playback-pause";
					action.activate.connect (() => { file.pause (); });
				}
				
				merged_action_group.add_action (action);
			}
			
			string new_ui = INSERT_TEMPLATE.printf (new_items.str);
			
			try {
				merge_id = ui_manager.add_ui_from_string(new_ui, new_ui.length);
			} catch (Error e) {
				Util.fatal_error (e);
			}
			
			ui_manager.insert_action_group (merged_action_group, 1);
			ui_manager.ensure_update ();
		}
		
		Services.indicator.set_menu (menu);
	}
	
	private void pause_all () {
		foreach (var file in Services.download.files) {
			if (file.can_pause ()) {
				file.pause ();
			}
		}
	}

	private void resume_all () {
		foreach (var file in Services.download.files) {
			if (file.can_start ()) {
				file.start (true);
			}
		}
	}

	public signal void show_hide_toggled (bool visible);
	public signal void add_download_clicked ();
	public signal void quit_clicked ();
}

}
