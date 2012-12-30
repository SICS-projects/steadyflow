/*
    Services.vala
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

using GLib.Process;
using Gtk;
using Steadyflow.Core;
using Steadyflow.UI;

namespace Steadyflow {

public class Services : GLib.Object {
	private Services () {}
	
	public static IDownloadService download { get; private set; }
	public static ISettingsService settings { get; private set; }
	public static IIndicatorService indicator { get; private set; }
	
	public static void init () {
		Util.signaller.fatal_error_sig.connect (exit_with_error);
		
		download = new DownloadService ();
		settings = AppConfig.create_settings ("net.launchpad.steadyflow");
		indicator = AppConfig.create_indicator ();
	}
	
	public static void done () {
		download = null;
		indicator = null;
		settings = null;
	}
	
	public static string get_default_download_folder () {
		string path = Services.settings.get_string ("default-download-folder");
		
		return (path == "") ? Environment.get_user_special_dir (UserDirectory.DOWNLOAD) : path;
	}
	
	[NoReturn]
	private static void exit_with_error (Error e, string? message = null) {
		if (message == null)
			message = e.message;
	
		MessageDialog md = new MessageDialog.with_markup (null, DialogFlags.MODAL, MessageType.ERROR,
				ButtonsType.CLOSE, UIUtil.MESSAGE_FORMAT, _("Whoopsie!"),
				_("Steadyflow has experienced a problem and needs to close. Please pass the following " +
				 "information to the developer:\n\nError Code %d:\n\n%s").printf (e.code, message));
			
		md.run ();
		exit(1);
	}
}

}
