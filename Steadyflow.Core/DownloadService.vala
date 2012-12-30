/*
    DownloadService.vala
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

namespace Steadyflow.Core {

public class DownloadService : GLib.Object, IDownloadService {
	private Gee.List<IDownloadFile> _files;
	private int last_uid;
	
	public Gee.List<IDownloadFile> files {
		owned get { return _files.read_only_view; }
	}
	
	public DownloadService () {
		_files = new ArrayList<IDownloadFile> ();
		last_uid = 0;
		load_state ();
	}
	
	~DownloadService () {
		save_state ();
	}
	
	public IDownloadFile? get_file_by_uid (int uid) {
		foreach (IDownloadFile file in files) {
			if (file.uid == uid)
				return file;
		}
		
		return null;
	}
	
	public IDownloadFile add_file (string url, string local_name, IDownloadFile.FinishAction finish_action,
			string? finish_command) throws Error {
		IDownloadFile file = new GioDownloadFile (url, local_name, last_uid, finish_action, finish_command);
		
		last_uid++;
		file.start (false);
		_files.add (file);
		file_added (file);
		file.status_changed.connect ((status) => { save_state (); });
		
		return file;
	}
	
	public void remove_file (IDownloadFile file) {
		_files.remove (file);
		save_state ();
		file_removed (file);
	}
	
	private File get_state_file () {
		string config_dir = Environment.get_user_data_dir ();
		File subdir = File.new_for_path (config_dir).get_child ("steadyflow");
		
		try {
			if (!subdir.query_exists (null)) {
				subdir.make_directory_with_parents (null);
			} else if (subdir.query_file_type (FileQueryInfoFlags.NONE, null) != FileType.DIRECTORY) {
				throw new FileError.NOTDIR (_(
					"Cannot create settings directory - a non-directory with that name already exists"));
			}
		} catch (Error e) {
			Util.fatal_error (e);
		}

		return subdir.get_child ("downloads.ini");
	}
	
	private void load_state () {
		KeyFile keys = new KeyFile ();
		int max_uid = 0;
		
		try {
			keys.load_from_file (get_state_file ().get_path (), KeyFileFlags.NONE);
			
			foreach (string group in keys.get_groups ()) {
				if (group == "ROOT")
					continue;
				
				bool should_start = false;
				int uid = int.parse(group);
				IDownloadFile file = GioDownloadFile.deserialize (keys, uid, out should_start);
				
				if (uid > max_uid)
					max_uid = uid;
				
				_files.add (file);
				file.status_changed.connect ((status) => { save_state (); });
				
				if (should_start)
					file.start ();
			}
			
			last_uid = max_uid + 1;
		} catch (Error e) {
			// cannot load state, alas
		}
	}
	
	private void save_state () {
		KeyFile keys = new KeyFile ();
		
		foreach (IDownloadFile file in files) {
			file.serialize (keys);
		}
		
		string file_contents = keys.to_data ();
		
		try {
			get_state_file ().replace_contents (file_contents.data, null, false, FileCreateFlags.NONE, null);
		} catch (Error e) {
			stderr.printf ("Cannot save downloads state");
		}
	}
}

}
