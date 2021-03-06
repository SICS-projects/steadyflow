install(TARGETS steadyflow DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/data/ui DESTINATION ${PROJECT_DATA_DIR})
install(DIRECTORY ${CMAKE_SOURCE_DIR}/data/img/hicolor DESTINATION ${COMMON_DATA_DIR}/icons)
install(FILES ${CMAKE_BINARY_DIR}/steadyflow.desktop DESTINATION ${COMMON_DATA_DIR}/applications)
install(FILES ${CMAKE_SOURCE_DIR}/data/net.launchpad.steadyflow.gschema.xml
	DESTINATION ${COMMON_DATA_DIR}/glib-2.0/schemas)

install(FILES ${CMAKE_SOURCE_DIR}/data/steadyflow.1 DESTINATION ${COMMON_DATA_DIR}/man/man1)
install(CODE "execute_process(COMMAND gzip ${COMMON_DATA_DIR}/man/man1/steadyflow.1)")

if(COMPILE_GSETTINGS_ON_INSTALL)
	add_gsettings_install_hook()
endif(COMPILE_GSETTINGS_ON_INSTALL)
