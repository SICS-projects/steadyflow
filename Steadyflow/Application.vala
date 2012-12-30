/*
    Application.vala
    Copyright (C) 2010-2012 Maia Kozheva <sikon@ubuntu.com>

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

namespace Steadyflow {

private static const string COMMAND_LINE_HELP = """
Syntax: steadyflow [command [args...] [-option1=value1] [-option2=value2]...]

Commands:
  steadyflow add [url]  - Add a file for download. If url is omitted, populates
                          the add dialog with the clipboard content if it is a
                          valid URL.
  steadyflow show       - Show the main window
  steadyflow hide       - Hide the main window
  steadyflow help       - Show this help screen
  steadyflow version    - Show version information
""";

public class Application {
	private delegate void CreateServiceCallback() throws IOError;

	private IAppService service;
	private OptionParser parser;
	private bool is_server = false;
	private uint service_id;

	// Set up gettext and the option parser in preparation for running the application
	public Application(string[] args) {
		string domain = "steadyflowj";
		Intl.textdomain (domain);
		Intl.bindtextdomain (domain, Util.is_local_install () ? "bin/locale" : AppConfig.DATA_DIR + "/locale");
		Intl.bind_textdomain_codeset (domain, "UTF-8");
		
		Notify.init (domain);
		
		parser = new OptionParser (args);
		
		parser.unhandled_command.connect (show_help);
		parser.register_command ("help", (args, kwargs) => { show_help (); });
		parser.register_command ("version", (args, kwargs) => { show_version (); });
		parser.register_command ("add", (args, kwargs) => {
			if (args.length > 1) {
				show_help ();
			} else if (args.length == 0) {
				create_service (ShowMainWindow.DEFAULT);
			} else {
				create_service (ShowMainWindow.DEFAULT, () =>  { service.add_file (args[0]); });
			}
		});
		parser.register_command ("show", (args, kwargs) => {
			create_service (ShowMainWindow.SHOW);
		});
		parser.register_command ("hide", (args, kwargs) => {
			create_service (ShowMainWindow.HIDE);
		});
		parser.register_command ("@default", (args, kwargs) => {
			create_service (ShowMainWindow.DEFAULT);
		});
	}
	
	public void run () {
		parser.run();
	}
	
	private void create_service(ShowMainWindow show_mode, CreateServiceCallback? callback = null) {
		uint bus_id = Bus.own_name (BusType.SESSION, "net.launchpad.steadyflow.App", BusNameOwnerFlags.NONE,
					(conn) => { on_bus_acquired (conn); },
					() => { on_name_acquired (show_mode, callback); },
					(conn) => { on_name_lost (conn, show_mode, callback); });
		
		Gtk.main ();
		
		if (is_server) {
			(service as AppService).stop ();
		}
		
		service = null;
		Bus.unown_name (bus_id);
	}
	
	private void on_bus_acquired (DBusConnection conn) {
		try {
			service = new AppService();
			service_id = conn.register_object ("/net/launchpad/steadyflow/app", service);
		} catch (IOError e) {
			// Do nothing, will try to connect to an existing instance
		}
	}
	
	private void on_name_acquired (ShowMainWindow show_mode, CreateServiceCallback? callback) {
		// This means we're the server
		is_server = true;
		
		try {
			(service as AppService).start (show_mode);
			
			if (callback != null) {
				callback();
			}
		} catch (Error e) {
			Util.fatal_error (e);
		}
	}
	
	private void on_name_lost (DBusConnection conn, ShowMainWindow show_mode, CreateServiceCallback? callback) {
		if (is_server) {
			// The server is shutting down
			return;
		}
		
		if (conn == null) {
			stderr.printf("%s\n", _("Cannot connect to D-Bus. Steadyflow will exit."));
		}
		
		// If we can't create a service, maybe there's an instance already running?
		try {
			service = Bus.get_proxy_sync (BusType.SESSION, "net.launchpad.steadyflow.App",
				"/net/launchpad/steadyflow/app");
			
			// Bring to front or hide if needed
			if (show_mode == ShowMainWindow.SHOW) {
				service.set_visible (true);
			} else if (show_mode == ShowMainWindow.HIDE) {
				service.set_visible (false);
			} else if (callback == null) {
				// And we have nothing to do...
				stderr.printf ("%s\n", _("Another instance of Steadyflow is already running."));
				Process.exit (1);
			}
		} catch (IOError e) {
			stderr.printf("%s\n", _(
					"Can neither create a D-Bus service nor connect to an existing instance of Steadyflow. " +
					"Steadyflow will now exit."));
			Process.exit(1);
		}
		
		try {
			if (callback != null) {
				callback();
			}
		} catch (Error e) {
			Util.fatal_error (e);
		}
		
		// Return control to create_service and shut down gracefully
		Gtk.main_quit ();
	}
	
	private void show_version () {
		stdout.printf(_("Steadyflow version %s") + "\n", AppConfig.APP_VERSION);
	}
	
	private void show_help () {
		show_version ();
		stdout.printf("%s", COMMAND_LINE_HELP);
	}

	public static int main (string[] args) {
		if (Util.is_local_install ()) {
			// Hack to make GSettings work locally, there should really be a better way...
			string xdg_data_dirs = Environment.get_variable ("XDG_DATA_DIRS");
		
			if (xdg_data_dirs == null)
				xdg_data_dirs = "/usr/local/share/:/usr/share/";
	
			Environment.set_variable ("XDG_DATA_DIRS", "bin/:" + xdg_data_dirs, true);
		}
		
		Gtk.init (ref args);
		Application app = new Application (args);
		app.run ();
		return 0;
	}
}

}
