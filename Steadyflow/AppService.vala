/*
    AppService.vala
    Copyright (C) 2012 Maia Kozheva <sikon@ubuntu.com>

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

public enum ShowMainWindow {
	DEFAULT,
	SHOW,
	HIDE
}

public class AppService: GLib.Object, IAppService {
	private NotificationController notifications;
	private MainWindow main_wnd;
	
	private bool started = false;
	
	public AppService () {
		// Do nothing... yet
	}
	
	public void start(ShowMainWindow show) throws Error {
		Services.init ();
		started = true;
		
		IconTheme.get_default ().append_search_path (Util.resolve_path ("img"));
		
		main_wnd = new MainWindow ();
		
		if (!Services.settings.get_boolean("show-indicator")) {
			main_wnd.show ();
		} else {
			main_wnd.realize (); // To correctly initialize size even if initially hidden
			bool start_minimized = Services.settings.get_boolean ("start-minimized");
			
			if (show == ShowMainWindow.SHOW || (show == ShowMainWindow.DEFAULT && !start_minimized)) {
				main_wnd.show ();
			} else {
				// We need to clear startup notify status manually if we start hidden
				Gdk.notify_startup_complete ();
			}
		}
		
		notifications = new NotificationController();
	}
	
	public void stop () {
		main_wnd = null;
		
		if (started) {
			Services.done();
			started = false;
		}
	}
	
	~AppService() {
		stop ();
	}
	
	public void add_file (string url) {
		main_wnd.add_download (url);
	}
	
	public void set_visible (bool visible) {
		main_wnd.set_visible (visible);
	}
}

}
