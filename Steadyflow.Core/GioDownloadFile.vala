/*
    GioDownloadFile.vala
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

public class GioDownloadFile : GLib.Object, IDownloadFile {
	private static const double SPEED_UPDATE_SEC = 2.0;
	
	private string _url;
	private string _local_name;
	private string _local_basename;
	private int _uid;
	private string _icon;
	private int64 _size;
	private int64 _old_downloaded_size;
	private int64 _downloaded_size;
	private int _speed;
	private IDownloadFile.FinishAction _finish_action;
	private string? _finish_command;
	private IDownloadFile.Status _status;
	private Error _error;
	private Timer timer;

	public GioDownloadFile (string url, string local_name, int uid,
			IDownloadFile.FinishAction finish_action, string? finish_command) {
		_url = url;
		_local_name = local_name;
		_uid = uid;
		_finish_action = finish_action;
		_finish_command = finish_command;
		
		File local_file = File.new_for_path (_local_name);
		_local_basename = local_file.get_basename ();
		File remote_file = File.new_for_uri (url);
		
		uchar[] data = null;
		string content_type = ContentType.guess (remote_file.get_basename (), data, null);
		Icon icon = ContentType.get_icon (content_type);
		
		if (icon is ThemedIcon)
			_icon = (icon as ThemedIcon).names[0];
		else
			_icon = "text-x-generic";

		_downloaded_size = 0;
		_old_downloaded_size = 0;
		_speed = 0;
		_status = IDownloadFile.Status.PAUSED;
		timer = new Timer ();
	}

	public IDownloadFile.Status status {
		get { return _status; }
	}
	
	public int uid {
		get { return _uid; }
	}
	
	public string url {
		get { return _url; }
	}
	
	public string local_name {
		get { return _local_name; }
	}
	
	public string local_basename {
		get { return _local_basename; }
	}
	
	public int64 size {
		get { return _size; }
	}
	
	public int64 downloaded_size {
		get { return _downloaded_size; }
	}
	
	public int speed {
		get { return _speed; }
	}
	
	public string icon_name {
		get { return _icon; }
	}
	
	public IDownloadFile.FinishAction finish_action {
		get { return _finish_action; }
	}
	
	public string? finish_command {
		get { return _finish_command; }
	}
	
	public Error? error {
		get { return _error; }
	}
	
	private void set_status (IDownloadFile.Status new_status) {
		IDownloadFile.Status old_status = _status;
		_status = new_status;
		
		if (new_status != IDownloadFile.Status.NETWORK_ERROR) {
			_error = null;
		}
		
		if (old_status != new_status) {
			status_changed (old_status);
		}
	}
	
	private void on_download_progress (int64 current, int64 total) {
		_size = total;
		double elapsed = timer.elapsed ();
		
		if (elapsed >= SPEED_UPDATE_SEC) {
			_speed = (int) ((current - _old_downloaded_size) / elapsed);
			// Now reset the timer
			timer.start ();
			_old_downloaded_size = current;
		}

		int64 old_size = _downloaded_size;
		_downloaded_size = current;
		download_progressed (old_size);
	}
	
	public void start (bool resume) {
		if (!can_start ())
			return;
		
		set_status (IDownloadFile.Status.CONNECTING);
		File file = File.new_for_uri (_url);
		
		timer.start ();
		do_download.begin (file, File.new_for_path (_local_name), resume, on_download_progress);
	}
	
	private async void do_download (File remote, File local, bool resume, FileProgressCallback on_progress) {
		try {
			try {
				yield remote.find_enclosing_mount_async (0);
			} catch (IOError e_mount) {
				// Not mounted
				MountOperation mount_op;
				get_mount_operation (out mount_op);
				yield remote.mount_enclosing_volume (MountMountFlags.NONE, mount_op);
			}
			
			try {
				FileInfo info = yield remote.query_info_async (FileAttribute.STANDARD_SIZE,
					FileQueryInfoFlags.NONE, 0);
				_size = (int64) info.get_attribute_uint64 (FileAttribute.STANDARD_SIZE);
			} catch (IOError e_query) {
				stderr.printf ("Cannot query file size, continuing with an unknown size\n");
			}
			
			FileInputStream input = yield remote.read_async ();
			FileOutputStream output;
			
			if (resume && input.can_seek () && local.query_exists ()) {
				output = yield local.append_to_async (FileCreateFlags.NONE, 0);
				output.seek (0, SeekType.END);
				_downloaded_size = output.tell ();
				input.seek (_downloaded_size, SeekType.SET);
			} else {
				output = yield local.replace_async (null, false, FileCreateFlags.NONE, 0);
			}
			
			set_status (IDownloadFile.Status.DOWNLOADING);
			uint8[] buf = new uint8[4096];
			
			while (status == IDownloadFile.Status.DOWNLOADING) {
				ssize_t read = yield input.read_async (buf);
				
				if (read == 0) {
					// End of file reached
					timer.stop ();
					set_status (IDownloadFile.Status.FINISHED);
					break;
				}
				
				yield output.write_async (buf[0:read]);
				on_download_progress (_downloaded_size + read, _size);
			}
		} catch (Error e) {
			_error = e;
			set_status (IDownloadFile.Status.NETWORK_ERROR);
			timer.stop ();
		}
	}
	
	public void pause () {
		if (can_pause ()) {
			set_status (IDownloadFile.Status.PAUSED);
			timer.stop ();
		}
	}
	
	public void serialize (KeyFile keys) {
		string group = uid.to_string ();
		keys.set_string (group, "url", url);
		keys.set_string (group, "local_name", local_name);
		keys.set_string (group, "size", size.to_string ());
		keys.set_integer (group, "status", (int) status);
		keys.set_integer (group, "finish_action", (int) finish_action);

		if (finish_action == IDownloadFile.FinishAction.RUN_COMMAND) {
			keys.set_string (group, "finish_command", finish_command);
		}
	}
	
	public static IDownloadFile deserialize (KeyFile keys, int uid, out bool should_start) throws Error {
		string group = uid.to_string ();
		string url = keys.get_string (group, "url");
		string local_name = keys.get_string (group, "local_name");
		int64 size = int64.parse(keys.get_string (group, "size"));
		IDownloadFile.Status status = (IDownloadFile.Status) keys.get_integer (group, "status");
		IDownloadFile.FinishAction finish_action =
			(IDownloadFile.FinishAction) keys.get_integer (group, "finish_action");
		string? finish_command = null;

		if (finish_action == IDownloadFile.FinishAction.RUN_COMMAND) {
			finish_command = keys.get_string (group, "finish_command");
		}
		
		GioDownloadFile file = new GioDownloadFile (url, local_name, uid, finish_action, finish_command);
		file._size = size;
		file._status = status;
		
		if (file.can_pause ()) {
			file._status = IDownloadFile.Status.PAUSED;
			should_start = true;
		} else {
			should_start = false;
		}
		
		try {
			File local_file = File.new_for_path (local_name);
			FileInfo info = local_file.query_info (FileAttribute.STANDARD_SIZE, FileQueryInfoFlags.NONE);
			file._downloaded_size = (int64) info.get_attribute_uint64 (FileAttribute.STANDARD_SIZE);
		} catch (Error e) {
			// Well, it means the file does not exist. Stuff happens.
		}
		
		return file;
	}
}

}
