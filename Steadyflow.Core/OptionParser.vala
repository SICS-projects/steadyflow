/*
    OptionParser.vala
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

public class OptionParser : GLib.Object {
	private string[] args;
	private Set<string> commands;
	
	public OptionParser (string[] args, bool remove_arg0 = true) {
		this.args = remove_arg0 ? args[1:args.length] : args;
		this.commands = new HashSet<string> ();
	}
	
	public void register_command (string cmd, OptionCommand handler) {
		commands.add (cmd);
		command[cmd].connect((args, kwargs) => { handler(args, kwargs); });
	}
	
	public void run () {
		Gee.List<string> arglist = new ArrayList<string> ();
		Map<string, string> kwargs = new HashMap<string, string> ();
		
		if (args.length == 0) {
			command["@default"] (args, kwargs);
			return;
		}
		
		string cmd = "@default";
		string[] arguments = args;
		
		if (args[0][0] != '-') {
			cmd = arguments[0];
			arguments = arguments[1:arguments.length];
		}
		
		foreach (string arg in arguments) {
			if (arg[0] != '-') {
				arglist.add (arg);
			} else {
				string[] keyvalue = arg.split ("=", 2);
				kwargs.set (keyvalue[0], keyvalue.length > 1 ? keyvalue[1] : null);
			}
		}
		
		if (cmd == "@default" || commands.contains (cmd)) {
			command[cmd] (arglist.to_array (), kwargs);
		} else {
			unhandled_command ();
		}
	}
	
	public delegate void OptionCommand (string[] args, Map<string, string> kwargs);
	
	[Signal (detailed = true)]
	private signal void command (string[] args, Map<string, string> kwargs);
	public signal void unhandled_command ();
}

}
