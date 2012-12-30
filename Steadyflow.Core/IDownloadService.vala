/*
    IDownloadService.vala
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

public interface IDownloadService : GLib.Object {
	public abstract Gee.List<IDownloadFile> files { owned get; }
	public abstract IDownloadFile? get_file_by_uid (int uid);
	public abstract IDownloadFile add_file (string url, string local_name,
		IDownloadFile.FinishAction finish_action = IDownloadFile.FinishAction.DO_NOTHING,
		string? finish_command = null) throws Error;
	public abstract void remove_file (IDownloadFile file);
	
	public signal void file_added (IDownloadFile file);
	public signal void file_removed (IDownloadFile file);
}

}
