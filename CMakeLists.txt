project(steadyflow C)
cmake_minimum_required(VERSION 2.6)

# Change version number on release
set(PROJECT_VERSION "0.2.0")
set(COMMON_DATA_DIR ${CMAKE_INSTALL_PREFIX}/share)
set(PROJECT_DATA_DIR ${CMAKE_INSTALL_PREFIX}/share/steadyflow)

list(APPEND CMAKE_MODULE_PATH
	${CMAKE_SOURCE_DIR}
	${CMAKE_SOURCE_DIR}/cmake
)

option(WANT_AYATANA "Compile with Ayatana libappindicator support" ON)
# Packagers: set the option below to off so it does not generate the binary schema on build.
option(COMPILE_GSETTINGS_ON_INSTALL "Compile GSettings schemas on install" ON)

set(VALA_REQUIRED_VERSION 0.16)
set(GLIB_REQUIRED_VERSION 2.30.0)
set(GTK_REQUIRED_VERSION 3.0.0)

find_package(PkgConfig REQUIRED)
find_package(Vala REQUIRED)
find_package(GTK3 REQUIRED)
find_package(ExtraDeps REQUIRED)

set(HAVE_AYATANA FALSE)

if(WANT_AYATANA AND APPINDICATOR_FOUND)
	set(HAVE_AYATANA TRUE)
endif(WANT_AYATANA AND APPINDICATOR_FOUND)

include(ValaVersion)
include(ValaPrecompile)
include(GSettings)
include(Po)
include(sources)

ensure_vala_version(${VALA_REQUIRED_VERSION} MINIMUM)

file (READ ${CMAKE_SOURCE_DIR}/AUTHORS PROJECT_AUTHORS)
string (REPLACE "\n" "\\n\\\n" PROJECT_AUTHORS ${PROJECT_AUTHORS})
configure_file(${CMAKE_SOURCE_DIR}/cmake/config.h.in ${CMAKE_BINARY_DIR}/config.h @ONLY)

set(CUSTOM_VAPIS
	# VAPI containing install definitions, mapping from cmake generated config.h
	${CMAKE_SOURCE_DIR}/vapi/AppConfig.vapi
)

set(VALA_PACKAGES
	gee-1.0
	gio-2.0
	glib-2.0
	gtk+-3.0
	gmodule-2.0
	libnotify
)

if(HAVE_AYATANA)
	set(VALA_PACKAGES ${VALA_PACKAGES} appindicator3-0.1)
endif(HAVE_AYATANA)

vala_precompile(VALA_C
	${STEADYFLOW_SOURCES}
CUSTOM_VAPIS
	${CUSTOM_VAPIS}
PACKAGES
	${VALA_PACKAGES}
)

# Rule for generating binary GSettings schema in working directory
gsettings_compile_schemas(${CMAKE_SOURCE_DIR}/data ${CMAKE_BINARY_DIR} net.launchpad.steadyflow)

set(DESKTOP_FILE_IN ${CMAKE_SOURCE_DIR}/data/steadyflow.desktop.in)
set(DESKTOP_FILE ${CMAKE_BINARY_DIR}/steadyflow.desktop)

# Merge translations of GenericName and X-GNOME-FullName from .po files into steadyflow.desktop
add_custom_command(OUTPUT ${DESKTOP_FILE}
		COMMAND ${CMAKE_SOURCE_DIR}/cmake/intltool-merge.pl
		ARGS -d ${CMAKE_SOURCE_DIR}/po ${DESKTOP_FILE_IN} ${DESKTOP_FILE}
		DEPENDS ${DESKTOP_FILE_IN}
	)

# Generate .mo from .po
compile_po_files(${CMAKE_SOURCE_DIR}/po LOCALE_FILES)

include_directories(${GTK3_ALL_INCLUDES} ${EXTRA_DEP_INCLUDES} ${CMAKE_BINARY_DIR})
add_definitions(${GTK3_ALL_CFLAGS} ${EXTRA_DEP_CFLAGS}
	-DGETTEXT_PACKAGE=\"${CMAKE_PROJECT_NAME}\"
)

add_executable(steadyflow ${VALA_C} ${GSCHEMAS_COMPILED} ${DESKTOP_FILE} ${LOCALE_FILES})
target_link_libraries(steadyflow ${GTK3_ALL_LIBS} ${EXTRA_DEP_LIBS})

include(install)
