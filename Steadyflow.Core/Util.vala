/*
    Util.vala
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

namespace Steadyflow.Core {

public class Util : GLib.Object {
	private Util () {}
	
	private static bool first_run = true;
	private static bool local_install;
	private static Util instance = null;
	
	public static Util signaller {
		get {
			if (instance == null)
				instance = new Util ();
		
			return instance;
		}
	}
	
	public static bool is_local_install () {
		if (first_run) {
			local_install = FileUtils.test ("Steadyflow/Application.vala", FileTest.EXISTS);
			first_run = false;
		}
		
		return local_install;
	}
	
	private static string get_data_dir () {
		if (is_local_install ())
			return "data";
		
		return AppConfig.APP_DATA_DIR;
	}
	
	public static string resolve_path (string rel_path) {
		return Path.build_filename (get_data_dir (), rel_path);
	}
	
	public static bool is_valid_url (string url) {
		// TODO: query supported schemes, will need fixed GLib.Vfs bindings
		return Uri.parse_scheme (url) != null;
	}
	
	[NoReturn]
	public static void fatal_error (Error e, string? message = null) {
		signaller.fatal_error_sig (e, message);
	}
	
	[NoReturn]
	public signal void fatal_error_sig (Error e, string? message = null);
}

}
