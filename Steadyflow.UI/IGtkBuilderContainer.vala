/*
    IGtkBuilderContainer.vala
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

namespace Steadyflow.UI {

public interface IGtkBuilderContainer {
	protected abstract Builder get_builder ();

	private static Builder resolve (string file_id) throws Error {
		string file_name = Util.resolve_path ("ui/" + file_id + ".ui");
		Builder builder = new Builder ();
		builder.add_from_file (file_name);
		return builder;
	}

	protected Builder init_builder (Container container, string file_id) {
		try {
			Builder builder = resolve (file_id);
			container.add ((Widget) builder.get_object ("_window_content"));
			return builder;
		} catch (Error e) {
			Util.fatal_error (e, _("Cannot find XML definition file for window %s").printf (file_id));
		}
	}
	
	protected void autoconnect () {
		get_builder ().connect_signals (this);
	}
	
	protected GLib.Object get_object (string id) {
		return get_builder ().get_object (id);
	}
}

}
