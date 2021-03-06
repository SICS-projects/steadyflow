/* ISettingsService.c generated by valac 0.16.1, the Vala compiler
 * generated from ISettingsService.vala, do not modify */

/*
    ISettingsService.vala
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

#include <glib.h>
#include <glib-object.h>
#include <stdlib.h>
#include <string.h>


#define STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE (steadyflow_core_isettings_service_get_type ())
#define STEADYFLOW_CORE_ISETTINGS_SERVICE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE, SteadyflowCoreISettingsService))
#define STEADYFLOW_CORE_IS_ISETTINGS_SERVICE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE))
#define STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE, SteadyflowCoreISettingsServiceIface))

typedef struct _SteadyflowCoreISettingsService SteadyflowCoreISettingsService;
typedef struct _SteadyflowCoreISettingsServiceIface SteadyflowCoreISettingsServiceIface;

struct _SteadyflowCoreISettingsServiceIface {
	GTypeInterface parent_iface;
	gboolean (*get_boolean) (SteadyflowCoreISettingsService* self, const gchar* key);
	gint (*get_int) (SteadyflowCoreISettingsService* self, const gchar* key);
	gint (*get_enum) (SteadyflowCoreISettingsService* self, const gchar* key);
	gchar* (*get_string) (SteadyflowCoreISettingsService* self, const gchar* key);
	void (*set_boolean) (SteadyflowCoreISettingsService* self, const gchar* key, gboolean value);
	void (*set_int) (SteadyflowCoreISettingsService* self, const gchar* key, gint value);
	void (*set_enum) (SteadyflowCoreISettingsService* self, const gchar* key, gint value);
	void (*set_string) (SteadyflowCoreISettingsService* self, const gchar* key, const gchar* value);
	void (*save) (SteadyflowCoreISettingsService* self);
};



GType steadyflow_core_isettings_service_get_type (void) G_GNUC_CONST;
gboolean steadyflow_core_isettings_service_get_boolean (SteadyflowCoreISettingsService* self, const gchar* key);
gint steadyflow_core_isettings_service_get_int (SteadyflowCoreISettingsService* self, const gchar* key);
gint steadyflow_core_isettings_service_get_enum (SteadyflowCoreISettingsService* self, const gchar* key);
gchar* steadyflow_core_isettings_service_get_string (SteadyflowCoreISettingsService* self, const gchar* key);
void steadyflow_core_isettings_service_set_boolean (SteadyflowCoreISettingsService* self, const gchar* key, gboolean value);
void steadyflow_core_isettings_service_set_int (SteadyflowCoreISettingsService* self, const gchar* key, gint value);
void steadyflow_core_isettings_service_set_enum (SteadyflowCoreISettingsService* self, const gchar* key, gint value);
void steadyflow_core_isettings_service_set_string (SteadyflowCoreISettingsService* self, const gchar* key, const gchar* value);
void steadyflow_core_isettings_service_save (SteadyflowCoreISettingsService* self);


gboolean steadyflow_core_isettings_service_get_boolean (SteadyflowCoreISettingsService* self, const gchar* key) {
	g_return_val_if_fail (self != NULL, FALSE);
	return STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->get_boolean (self, key);
}


gint steadyflow_core_isettings_service_get_int (SteadyflowCoreISettingsService* self, const gchar* key) {
	g_return_val_if_fail (self != NULL, 0);
	return STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->get_int (self, key);
}


gint steadyflow_core_isettings_service_get_enum (SteadyflowCoreISettingsService* self, const gchar* key) {
	g_return_val_if_fail (self != NULL, 0);
	return STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->get_enum (self, key);
}


gchar* steadyflow_core_isettings_service_get_string (SteadyflowCoreISettingsService* self, const gchar* key) {
	g_return_val_if_fail (self != NULL, NULL);
	return STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->get_string (self, key);
}


void steadyflow_core_isettings_service_set_boolean (SteadyflowCoreISettingsService* self, const gchar* key, gboolean value) {
	g_return_if_fail (self != NULL);
	STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->set_boolean (self, key, value);
}


void steadyflow_core_isettings_service_set_int (SteadyflowCoreISettingsService* self, const gchar* key, gint value) {
	g_return_if_fail (self != NULL);
	STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->set_int (self, key, value);
}


void steadyflow_core_isettings_service_set_enum (SteadyflowCoreISettingsService* self, const gchar* key, gint value) {
	g_return_if_fail (self != NULL);
	STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->set_enum (self, key, value);
}


void steadyflow_core_isettings_service_set_string (SteadyflowCoreISettingsService* self, const gchar* key, const gchar* value) {
	g_return_if_fail (self != NULL);
	STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->set_string (self, key, value);
}


void steadyflow_core_isettings_service_save (SteadyflowCoreISettingsService* self) {
	g_return_if_fail (self != NULL);
	STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE (self)->save (self);
}


static void steadyflow_core_isettings_service_base_init (SteadyflowCoreISettingsServiceIface * iface) {
	static gboolean initialized = FALSE;
	if (!initialized) {
		initialized = TRUE;
		g_signal_new ("changed", STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE, G_SIGNAL_RUN_LAST | G_SIGNAL_DETAILED, 0, NULL, NULL, g_cclosure_marshal_VOID__VOID, G_TYPE_NONE, 0);
	}
}


GType steadyflow_core_isettings_service_get_type (void) {
	static volatile gsize steadyflow_core_isettings_service_type_id__volatile = 0;
	if (g_once_init_enter (&steadyflow_core_isettings_service_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (SteadyflowCoreISettingsServiceIface), (GBaseInitFunc) steadyflow_core_isettings_service_base_init, (GBaseFinalizeFunc) NULL, (GClassInitFunc) NULL, (GClassFinalizeFunc) NULL, NULL, 0, 0, (GInstanceInitFunc) NULL, NULL };
		GType steadyflow_core_isettings_service_type_id;
		steadyflow_core_isettings_service_type_id = g_type_register_static (G_TYPE_INTERFACE, "SteadyflowCoreISettingsService", &g_define_type_info, 0);
		g_type_interface_add_prerequisite (steadyflow_core_isettings_service_type_id, G_TYPE_OBJECT);
		g_once_init_leave (&steadyflow_core_isettings_service_type_id__volatile, steadyflow_core_isettings_service_type_id);
	}
	return steadyflow_core_isettings_service_type_id__volatile;
}



