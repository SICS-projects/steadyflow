/*
    TrayIndicatorService.vala
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
using Steadyflow.UI;

namespace Steadyflow.UI {

public class TrayIndicatorService : GLib.Object, IIndicatorService {
	private StatusIcon status_icon;
	private Gtk.Menu menu;
	
	public TrayIndicatorService (string icon_name) {
		status_icon = new StatusIcon.from_icon_name (icon_name);
		menu = null;
		
		status_icon.button_press_event.connect ((e) => { on_button_press (e.button, e.time); return true; });
		status_icon.popup_menu.connect (on_popup_menu);
	}

	private void on_button_press (uint button, uint time) {
		if (button == 1) { // Left button
			clicked ();
		} else {
			on_popup_menu (button, time);
		}
	}
	
	private void on_popup_menu (uint button, uint time) {
		if (menu == null) {
			stderr.printf ("No menu set for TrayIndicatorService\n");
			return;
		}
		
		menu.popup (null, null, status_icon.position_menu, button, time);
	}
	
	public string icon_name {
		owned get { return status_icon.icon_name; }
		set { status_icon.icon_name = value; }
	}
	
	public void set_menu (Gtk.Menu value) {
		menu = value;
	}
	
	public bool visible {
		get { return status_icon.visible; }
		set { status_icon.visible = value; }
	}
}

}

namespace Steadyflow.Core.AppConfig {
	public static IIndicatorService create_indicator () {
		return new TrayIndicatorService ("steadyflow");
	}
}
