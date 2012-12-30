/*
    GioSettingsService.vala
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

public class GioSettingsService : GLib.Object, ISettingsService {
	private GLib.Settings gs;

	public GioSettingsService (string schema) {
		gs = new GLib.Settings (schema);
		gs.changed.connect ((key) => { this.changed[key] (); });
	}

	public bool get_boolean (string key) {
		return gs.get_boolean (key);
	}

	public int get_int (string key) {
		return gs.get_int (key);
	}

	public int get_enum (string key) {
		return gs.get_enum (key);
	}

	public string get_string (string key) {
		return gs.get_string (key);
	}

	public void set_boolean (string key, bool value) {
		gs.set_boolean (key, value);
	}

	public void set_int (string key, int value) {
		gs.set_int (key, value);
	}

	public void set_enum (string key, int value) {
		gs.set_enum (key, value);
	}

	public void set_string (string key, string value) {
		gs.set_string (key, value);
	}

	public void save () {
		gs.apply ();
	} 
}

namespace AppConfig {
	public static ISettingsService create_settings (string schema) {
		return new GioSettingsService (schema);
	}
}

}
