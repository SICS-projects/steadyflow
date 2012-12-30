/*
    MainWindow.vala
    Copyright (C) 2010-2011 Maia Kozheva <sikon@ubuntu.com>

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

private static const string LICENSE = """
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
""";

// Needed for desktop file
private static const string X_GNOME_FULL_NAME = _("Steadyflow Download Manager");

public class MainWindow : GtkBuilderWindow {
	private Toolbar toolbar;
	private Container statuspanel;
	private Container filestatuspanel;
	private Label url_label;
	private Label local_label;
	private Label status_label;
	private Gtk.Menu m_item_popup;
	private Entry searchbox;
	private ToggleToolButton t_edit;
	
	private Gtk.Action a_start;
	private Gtk.Action a_pause;
	private Gtk.Action a_remove;
	private Gtk.Action a_open_file;
	private Gtk.Action a_open_folder;
	private Gtk.Action a_copy_link;
	private ToggleAction a_view_statuspanel;

	private IndicatorController indicator_controller;
	private FileListController file_list_controller;

	public MainWindow () throws GLib.Error {
		base ("MainWindow");

		this.title = _("Download Manager");
		this.icon_name = "steadyflow";
		indicator_controller = new IndicatorController ();
		file_list_controller = new FileListController ((TreeView) get_object ("tree"));
		
		toolbar = (Toolbar) get_object ("toolbar");
		t_edit = (ToggleToolButton) get_object ("t_edit");
		statuspanel = (Container) get_object ("statuspanel");
		filestatuspanel = (Container) get_object ("filestatuspanel");
		url_label = (Label) get_object ("url_label");
		local_label = (Label) get_object ("local_label");
		status_label = (Label) get_object ("status_label");
		m_item_popup = (Gtk.Menu) get_object ("m_item_popup");
		searchbox = (Entry) get_object ("searchbox");
		
		a_start = (Gtk.Action) get_object ("a_start");
		a_pause = (Gtk.Action) get_object ("a_pause");
		a_remove = (Gtk.Action) get_object ("a_remove");
		a_view_statuspanel = (ToggleAction) get_object ("a_view_statuspanel");
		a_open_file = (Gtk.Action) get_object ("a_open_file");
		a_open_folder = (Gtk.Action) get_object ("a_open_folder");
		a_copy_link = (Gtk.Action) get_object ("a_copy_link");
		
		set_statuspanel_visible (Services.settings.get_boolean ("show-statuspanel"));
		set_default_size (Services.settings.get_int ("window-width"), Services.settings.get_int ("window-height"));
		set_position (WindowPosition.CENTER);

		Services.settings.changed["show-statuspanel"].connect (() => {
			set_statuspanel_visible (Services.settings.get_boolean ("show-statuspanel"));
		});
		
		indicator_controller.show_hide_toggled.connect ((value) => { this.visible = value; });
		indicator_controller.add_download_clicked.connect (() => { add_download (); });
		indicator_controller.quit_clicked.connect (() => { destroy (); });
		
		file_list_controller.selection_changed.connect (on_selection_changed);
		file_list_controller.filelist_changed.connect (update_searchbox_and_file_counts);
		
		UIUtil.install_clear_handler (searchbox);

		this.configure_event.connect(on_resize);
		this.destroy.connect (Gtk.main_quit);
		this.delete_event.connect (() => { return on_close(); });
		autoconnect ();
		update_searchbox_and_file_counts ();
	}

	private bool on_resize (Gdk.EventConfigure event) {
		Services.settings.set_int ("window-width", event.width);
		Services.settings.set_int ("window-height", event.height);
		Services.settings.save ();
		return false;
	}
	
	private bool on_close () {
		if (Services.indicator.visible && Services.settings.get_boolean ("minimize-to-indicator")) {
			hide ();
			indicator_controller.set_main_window_visible (false);
			return true;
		}
		
		// Otherwise carry on with closing the window
		return false;
	}
	
	[CCode (instance_pos = -1)]
	protected void on_quit (Gtk.MenuItem sender) {
		destroy ();
	}
	
	private void on_selection_changed () {
		var selection = file_list_controller.get_selected_files ();
		a_remove.set_sensitive (!selection.is_empty);
		
		if (selection.size == 1) {
			filestatuspanel.set_sensitive (true);
			
			var file = selection.get (0);
			url_label.set_text (file.url);
			local_label.set_text (file.local_name);
		} else {
			filestatuspanel.set_sensitive (false);
			url_label.set_text ("");
			local_label.set_text ("");
		}
		
		bool can_start = false;
		bool can_pause = false;

		foreach (var file in selection) {
			if (file.can_start ()) {
				can_start = true;
			}
			
			if (file.can_pause ()) {
				can_pause = true;
			}
			
			if (can_start && can_pause) {
				break;
			}
		}
		
		a_start.set_sensitive (can_start);
		a_pause.set_sensitive (can_pause);
	}

	private void set_statuspanel_visible (bool visible) {
		if (statuspanel.visible != visible)
			statuspanel.visible = visible;
		
		if (a_view_statuspanel.active != visible)
			a_view_statuspanel.active = visible;
	}

	[CCode (instance_pos = -1)]
	protected void on_view_statuspanel (ToggleAction sender) {
		Services.settings.set_boolean ("show-statuspanel", sender.active);
	}

	[CCode (instance_pos = -1)]
	protected void on_file_add (Gtk.Action sender) {
		add_download ();
	}
	
	internal void add_download (string starting_url = "") {
		AddFileDialog dlg = new AddFileDialog (starting_url);
		
		dlg.file_add_request.connect (file_list_controller.on_file_add_request);
		dlg.show ();
	}

	[CCode (instance_pos = -1)]
	protected void on_file_start (Gtk.Action sender) {
		foreach (IDownloadFile file in file_list_controller.get_selected_files ()) {
			file.start ();
		}
	}

	[CCode (instance_pos = -1)]
	protected void on_file_pause (Gtk.Action sender) {
		foreach (IDownloadFile file in file_list_controller.get_selected_files ()) {
			file.pause ();
		}
	}

	[CCode (instance_pos = -1)]
	protected void on_file_remove (Gtk.Action sender) {
		foreach (IDownloadFile file in file_list_controller.get_selected_files ()) {
			if (file.status != IDownloadFile.Status.FINISHED) {
				MessageDialog md = new MessageDialog.with_markup (this, DialogFlags.MODAL, MessageType.WARNING,
					ButtonsType.NONE, UIUtil.MESSAGE_FORMAT,
					_("The file \"%s\" is not downloaded yet").printf (file.local_basename),
					_("The file you request to be removed from the download list is not yet fully downloaded. " +
					"Are you sure you want to remove it?"));
				
				md.add_button (Stock.CANCEL, ResponseType.CANCEL);
				md.add_button (Stock.REMOVE, ResponseType.OK);
				int response = md.run ();
				md.destroy ();
				
				if (response != ResponseType.OK)
					return;
			}
			
			Services.download.remove_file (file);
		}

		on_selection_changed ();
	}

	[CCode (instance_pos = -1)]
	protected void on_open_file (Gtk.Action sender) {
		open_selected_file ();
	}
	
	private void open_selected_file () {
		IDownloadFile? file = file_list_controller.get_selected_file ();
		
		if (file == null)
			return;
		
		UIUtil.open_file (file);
	}

	[CCode (instance_pos = -1)]
	protected void on_open_folder (Gtk.Action sender) {
		IDownloadFile? file = file_list_controller.get_selected_file ();
		
		if (file == null)
			return;
		
		UIUtil.open_folder (file);
	}

	[CCode (instance_pos = -1)]
	protected void on_copy_link (Gtk.Action sender) {
		IDownloadFile? file = file_list_controller.get_selected_file ();
		
		if (file == null)
			return;
		
		Clipboard.get (Gdk.SELECTION_CLIPBOARD).set_text (file.url, file.url.length);
	}

	[CCode (instance_pos = -1)]
	protected void on_edit_preferences (Gtk.MenuItem sender) {
		PreferencesDialog dlg = new PreferencesDialog (this);
		dlg.run ();
		dlg.destroy ();
	}

	private static void show_uri (string uri) {
		try {
			Gtk.show_uri (null, uri, Gdk.CURRENT_TIME);
		} catch (Error e) {
			Util.fatal_error (e, _("Could not launch web browser for URL %s").printf (uri));
		}
	}

	[CCode (instance_pos = -1)]
	protected void on_help_reportbug (Gtk.MenuItem sender) {
		show_uri ("https://bugs.launchpad.net/steadyflow");
	}

	[CCode (instance_pos = -1)]
	protected void on_help_translate (Gtk.MenuItem sender) {
		show_uri ("https://translations.launchpad.net/steadyflow");
	}

	[CCode (instance_pos = -1)]
	protected void on_help_about (Gtk.MenuItem sender) {
		AboutDialog dlg = new AboutDialog ();
		
		dlg.authors = AppConfig.APP_AUTHORS.split("\n");
		dlg.copyright = "Copyright © 2010-2012 Maia Kozheva <sikon@ubuntu.com>";
		dlg.license = LICENSE;
		dlg.logo_icon_name = "steadyflow";
		dlg.program_name = "Steadyflow";
		dlg.comments = _("Simple download manager for GNOME");
		dlg.version = AppConfig.APP_VERSION;
		dlg.website = "https://launchpad.net/steadyflow";
		dlg.website_label = _("Website");
		dlg.translator_credits = _("translator-credits");
		
		dlg.run ();
		dlg.destroy ();
	}
	
	private void on_menu_position (Gtk.Menu menu, out int x, out int y, out bool push_in) {
		Allocation alloc;
		int win_x;
		int win_y;
		
		t_edit.get_allocation (out alloc);
		t_edit.get_window ().get_origin (out win_x, out win_y);
		x = win_x + alloc.x;
		y = win_y + alloc.y + alloc.height;
		push_in = true;
	}

	[CCode (instance_pos = -1)]
	protected void on_menu_edit (ToolButton sender) {
		if (t_edit.active) {
			Gtk.Menu menu = (Gtk.Menu) get_object ("m_edit_s");
			menu.popup (null, null, on_menu_position, 1, Gdk.CURRENT_TIME);
		}
	}

	[CCode (instance_pos = -1)]
	protected void on_app_menu_deactivate (Gtk.Menu sender) {
		t_edit.active = false;
	}

	[CCode (instance_pos = -1)]
	protected void on_searchbox_changed (Entry sender) {
		file_list_controller.set_filter (sender.text);
	}
	
	[CCode (instance_pos = -1)]
	protected bool on_tree_key_press (TreeView sender, Gdk.EventKey e) {
		if (Gdk.keyval_name (e.keyval) == "Delete")
			on_file_remove (a_remove);
		
		return false;
	}
	
	[CCode (instance_pos = -1)]
	protected bool on_tree_button_press (TreeView sender, Gdk.EventButton e) {
		if (e.button == 1 && e.type == Gdk.EventType.2BUTTON_PRESS) {
			open_selected_file ();
		} else if (e.button == 3 && file_list_controller.get_selected_files ().contains (
				file_list_controller.get_file_at_widget_pos ((int) e.x, (int) e.y))) {
			return true;
		}
		
		return false;
	}
	
	[CCode (instance_pos = -1)]
	protected bool on_tree_button_release (TreeView sender, Gdk.EventButton e) {
		if (e.button == 3) {
			tree_popup_menu (e.button, e.time);
			return true;
		}
		
		return false;
	}
	
	[CCode (instance_pos = -1)]
	protected bool on_tree_popup_menu (TreeView sender) {
		tree_popup_menu (3, Gdk.CURRENT_TIME);
		return true;
	}
	
	private void tree_popup_menu (uint button, uint time) {
		int file_count = file_list_controller.get_selection_count ();
		
		if (file_count == 0) {
			return;
		} else if (file_count == 1) {
			var file = file_list_controller.get_selected_file ();
			a_open_file.sensitive = file.status == IDownloadFile.Status.FINISHED;
			a_open_folder.sensitive = true;
			a_copy_link.sensitive = true;
		} else {
			a_open_file.sensitive = false;
			a_open_folder.sensitive = false;
			a_copy_link.sensitive = false;
		}
		
		m_item_popup.popup (null, null, null, button, time);
	}
	
	private void update_searchbox_and_file_counts() {
		searchbox.set_sensitive (!Services.download.files.is_empty);

		int downloading = 0;
		int paused = 0;
		int finished = 0;
	
		foreach (IDownloadFile file in Services.download.files) {
			switch (file.status) {
			case IDownloadFile.Status.DOWNLOADING:
				downloading++;
				break;
			case IDownloadFile.Status.FINISHED:
				finished++;
				break;
			default:
				paused++;
				break;
			}
		}
		
		status_label.set_text (_("%d downloading, %d paused, %d finished").printf (downloading, paused, finished));
	}

	[CCode (instance_pos = -1)]
	protected void on_deploy_surprise (Widget sender, Gdk.EventButton e) {
		if ((e.state & Gdk.ModifierType.SHIFT_MASK) != 0 && e.button == 2) {
			MessageDialog md = new MessageDialog.with_markup (this, DialogFlags.MODAL, MessageType.INFO,
				ButtonsType.CLOSE, UIUtil.MESSAGE_FORMAT, "♥", "Surprise deployed!");
			
			md.run ();
			md.destroy ();
		}
	}
}

}
