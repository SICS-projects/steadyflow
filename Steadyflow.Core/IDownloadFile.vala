/*
    IDownloadFile.vala
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

public interface IDownloadFile : GLib.Object {
	public enum Status {
		CONNECTING = 0,
		DOWNLOADING,
		PAUSED,
		FINISHED,
		NETWORK_ERROR
	}

	public enum FinishAction {
		DO_NOTHING = 0,
		OPEN_FILE,
		OPEN_FOLDER,
		RUN_COMMAND
	}

	public abstract Status status { get; }
	public abstract int uid { get; }
	public abstract string url { get; }
	public abstract string local_name { get; }
	public abstract string local_basename { get; }
	public abstract int64 size { get; }
	public abstract int64 downloaded_size { get; }
	public abstract int speed { get; }
	public abstract string icon_name { get; }
	public abstract FinishAction finish_action { get; }
	public abstract string? finish_command { get; }
	public abstract Error? error { get; }
	
	public abstract void start (bool resume = true);
	public abstract void pause ();
	public abstract void serialize (KeyFile file);
	
	public bool can_start () {
		return status == Status.PAUSED || status == Status.NETWORK_ERROR;
	}
	
	public bool can_pause () {
		return status == Status.CONNECTING || status == Status.DOWNLOADING;
	}
	
	public signal void status_changed (Status old_status);
	public signal void download_progressed (int64 old_size);
	public signal void get_mount_operation (out MountOperation mount_op);
}

}
