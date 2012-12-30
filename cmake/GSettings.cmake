macro(gsettings_compile_schemas input_dir output_dir schema_files)
	set(qualified_schema_files "")
	foreach(file ${schema_files})
		set(qualified_schema_files ${qualified_schema_files} "${input_dir}/${file}.gschema.xml")
	endforeach(file ${schema_files})
	set(GSCHEMAS_COMPILED "${output_dir}/glib-2.0/schemas/gschemas.compiled")
	file(MAKE_DIRECTORY "${output_dir}/glib-2.0/schemas")
	add_custom_command(OUTPUT ${GSCHEMAS_COMPILED}
		COMMAND "glib-compile-schemas"
		ARGS "--targetdir=${output_dir}/glib-2.0/schemas" ${input_dir}
		DEPENDS ${qualified_schema_files}
	)
endmacro(gsettings_compile_schemas)

macro(add_gsettings_install_hook)
	install(CODE "message(\"-- Compiling GSettings XML schemas...\")")
	install(CODE "execute_process(COMMAND glib-compile-schemas ${CMAKE_INSTALL_PREFIX}/share/glib-2.0/schemas)")
endmacro(add_gsettings_install_hook)
