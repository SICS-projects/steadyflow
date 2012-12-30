/*
    AyatanaIndicatorService.vala
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

using AppIndicator;
using Steadyflow.UI;

namespace Steadyflow.UI {

public class AyatanaIndicatorService : GLib.Object, IIndicatorService {
	private Indicator indicator;

	public AyatanaIndicatorService (string id, string icon_name, string? icon_theme_path) {
		if (icon_theme_path == null) {
			indicator = new Indicator (id, icon_name, IndicatorCategory.APPLICATION_STATUS);
		} else {
			indicator = new Indicator.with_path (id, icon_name, IndicatorCategory.APPLICATION_STATUS,
				File.new_for_path (icon_theme_path).get_path ());
		}
	}
	
	public string icon_name {
		owned get { return indicator.get_icon (); }
		set { indicator.set_icon (value); }
	}
	
	public void set_menu (Gtk.Menu value) {
		indicator.set_menu (value);
	}
	
	public bool visible {
		get { return indicator.get_status () != IndicatorStatus.PASSIVE; }
		set { indicator.set_status (value ? IndicatorStatus.ACTIVE : IndicatorStatus.PASSIVE); }
	}
}

}

namespace Steadyflow.Core.AppConfig {
	public static IIndicatorService create_indicator () {
		string iconpath = Util.is_local_install () ? Util.resolve_path ("img") : null;
		return new AyatanaIndicatorService ("steadyflow", "steadyflow", iconpath);
	}
}
