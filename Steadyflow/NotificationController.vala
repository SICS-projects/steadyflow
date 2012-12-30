/*
    NotificationController.vala
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
using Steadyflow.Core;
using Steadyflow.UI;

namespace Steadyflow {

public class NotificationController : GLib.Object {
	private Set<IDownloadFile> start_notified;
	private Set<IDownloadFile> finished_notified;

	public NotificationController () {
		start_notified = new HashSet<IDownloadFile> ();
		finished_notified = new HashSet<IDownloadFile> ();
		Services.download.file_added.connect (on_file_added);
		Services.download.file_removed.connect (on_file_removed);
		
		foreach (IDownloadFile file in Services.download.files) {
			file.status_changed.connect (on_status_changed);
			start_notified.add (file);
			finished_notified.add (file);
		}
	}
	
	private void on_file_added (IDownloadFile file) {
		file.status_changed.connect (on_status_changed);
	}
	
	private void on_file_removed (IDownloadFile file) {
		start_notified.remove (file);
		finished_notified.remove (file);
	}
	
	private void on_status_changed (IDownloadFile sender, IDownloadFile.Status old_status) {
		if (Services.settings.get_boolean ("show-notifications")) {
			try {
				if (sender.status == IDownloadFile.Status.DOWNLOADING && !start_notified.contains (sender)) {
					new Notify.Notification (_("Download Started"), sender.local_basename, sender.icon_name).show ();
			
					start_notified.add (sender);
				} else if (sender.status == IDownloadFile.Status.FINISHED && !finished_notified.contains (sender)) {
					new Notify.Notification (_("Download Complete"), sender.local_basename, sender.icon_name).show ();
			
					finished_notified.add (sender);
				}
			} catch (Error e) {
				stderr.printf ("Could not display notification\n");
			}
		}

		// Execute post-download action

		if (sender.status == IDownloadFile.Status.FINISHED) {
			switch (sender.finish_action) {
			case IDownloadFile.FinishAction.OPEN_FILE:
				UIUtil.open_file (sender);
				break;
			case IDownloadFile.FinishAction.OPEN_FOLDER:
				UIUtil.open_folder (sender);
				break;
			case IDownloadFile.FinishAction.RUN_COMMAND:
				if (sender.finish_command != null) {
					try {
						Process.spawn_command_line_async (sender.finish_command);
					} catch (Error e) {
						stderr.printf ("Could not run process\n");
					}
				}
				break;
			}
		}
	}
}

}
