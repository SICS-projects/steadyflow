/*
    config.h.in
    Copyright (C) 2010-2011 Maia Kozheva <sikon@ubuntu.com>

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

#ifndef CONFIG_H
#define CONFIG_H

/*
    Macro definitions for CMake
    
    From a Vala program, you will not need to directly reference this file.
    Instead, see AppConfig.vapi. Only change both if you know what you're doing.
*/

#define CMAKE_INSTALL_PREFIX "/usr/local"
#define CMAKE_INSTALL_BIN_DIR "/usr/local/bin"
#define CMAKE_INSTALL_DATA_DIR "/usr/local/share"
#define CMAKE_INSTALL_APP_DATA_DIR "/usr/local/share/steadyflow"
#define CMAKE_APP_VERSION "0.2.0"
#define CMAKE_APP_AUTHORS "Code:\n\
- Maia Kozheva <sikon@ubuntu.com>\n\
\n\
Contributions by:\n\
- Thura <trhura@gmail.com>\n\
- Hunter Rew <hbrshred@gmail.com>\n\
\n\
The cloud-and-arrow icon is copyright by Daniel Fore <daniel.p.fore@gmail.com>\n\
and licensed under the GNU GPL.\n\
"

#endif
