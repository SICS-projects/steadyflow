/* IAppService.c generated by valac 0.16.1, the Vala compiler
 * generated from IAppService.vala, do not modify */

/*
    IAppService.vala
    Copyright (C) 2012 Maia Kozheva <sikon@ubuntu.com>

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
#include <gio/gio.h>
#include <stdlib.h>
#include <string.h>


#define STEADYFLOW_TYPE_IAPP_SERVICE (steadyflow_iapp_service_get_type ())
#define STEADYFLOW_IAPP_SERVICE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_TYPE_IAPP_SERVICE, SteadyflowIAppService))
#define STEADYFLOW_IS_IAPP_SERVICE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_TYPE_IAPP_SERVICE))
#define STEADYFLOW_IAPP_SERVICE_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), STEADYFLOW_TYPE_IAPP_SERVICE, SteadyflowIAppServiceIface))

typedef struct _SteadyflowIAppService SteadyflowIAppService;
typedef struct _SteadyflowIAppServiceIface SteadyflowIAppServiceIface;

#define STEADYFLOW_TYPE_IAPP_SERVICE_PROXY (steadyflow_iapp_service_proxy_get_type ())
typedef GDBusProxy SteadyflowIAppServiceProxy;
typedef GDBusProxyClass SteadyflowIAppServiceProxyClass;
#define _g_free0(var) (var = (g_free (var), NULL))

struct _SteadyflowIAppServiceIface {
	GTypeInterface parent_iface;
	void (*add_file) (SteadyflowIAppService* self, const gchar* url, GError** error);
	void (*set_visible) (SteadyflowIAppService* self, gboolean visible, GError** error);
};



GType steadyflow_iapp_service_proxy_get_type (void) G_GNUC_CONST;
guint steadyflow_iapp_service_register_object (void* object, GDBusConnection* connection, const gchar* path, GError** error);
GType steadyflow_iapp_service_get_type (void) G_GNUC_CONST;
void steadyflow_iapp_service_add_file (SteadyflowIAppService* self, const gchar* url, GError** error);
void steadyflow_iapp_service_set_visible (SteadyflowIAppService* self, gboolean visible, GError** error);
static void steadyflow_iapp_service_proxy_g_signal (GDBusProxy* proxy, const gchar* sender_name, const gchar* signal_name, GVariant* parameters);
static void steadyflow_iapp_service_proxy_add_file (SteadyflowIAppService* self, const gchar* url, GError** error);
static void steadyflow_iapp_service_proxy_set_visible (SteadyflowIAppService* self, gboolean visible, GError** error);
static void steadyflow_iapp_service_proxy_steadyflow_iapp_service_interface_init (SteadyflowIAppServiceIface* iface);
static void _dbus_steadyflow_iapp_service_add_file (SteadyflowIAppService* self, GVariant* parameters, GDBusMethodInvocation* invocation);
static void _dbus_steadyflow_iapp_service_set_visible (SteadyflowIAppService* self, GVariant* parameters, GDBusMethodInvocation* invocation);
static void steadyflow_iapp_service_dbus_interface_method_call (GDBusConnection* connection, const gchar* sender, const gchar* object_path, const gchar* interface_name, const gchar* method_name, GVariant* parameters, GDBusMethodInvocation* invocation, gpointer user_data);
static GVariant* steadyflow_iapp_service_dbus_interface_get_property (GDBusConnection* connection, const gchar* sender, const gchar* object_path, const gchar* interface_name, const gchar* property_name, GError** error, gpointer user_data);
static gboolean steadyflow_iapp_service_dbus_interface_set_property (GDBusConnection* connection, const gchar* sender, const gchar* object_path, const gchar* interface_name, const gchar* property_name, GVariant* value, GError** error, gpointer user_data);
static void _steadyflow_iapp_service_unregister_object (gpointer user_data);

static const GDBusArgInfo _steadyflow_iapp_service_dbus_arg_info_add_file_url = {-1, "url", "s"};
static const GDBusArgInfo * const _steadyflow_iapp_service_dbus_arg_info_add_file_in[] = {&_steadyflow_iapp_service_dbus_arg_info_add_file_url, NULL};
static const GDBusArgInfo * const _steadyflow_iapp_service_dbus_arg_info_add_file_out[] = {NULL};
static const GDBusMethodInfo _steadyflow_iapp_service_dbus_method_info_add_file = {-1, "AddFile", (GDBusArgInfo **) (&_steadyflow_iapp_service_dbus_arg_info_add_file_in), (GDBusArgInfo **) (&_steadyflow_iapp_service_dbus_arg_info_add_file_out)};
static const GDBusArgInfo _steadyflow_iapp_service_dbus_arg_info_set_visible_visible = {-1, "visible", "b"};
static const GDBusArgInfo * const _steadyflow_iapp_service_dbus_arg_info_set_visible_in[] = {&_steadyflow_iapp_service_dbus_arg_info_set_visible_visible, NULL};
static const GDBusArgInfo * const _steadyflow_iapp_service_dbus_arg_info_set_visible_out[] = {NULL};
static const GDBusMethodInfo _steadyflow_iapp_service_dbus_method_info_set_visible = {-1, "SetVisible", (GDBusArgInfo **) (&_steadyflow_iapp_service_dbus_arg_info_set_visible_in), (GDBusArgInfo **) (&_steadyflow_iapp_service_dbus_arg_info_set_visible_out)};
static const GDBusMethodInfo * const _steadyflow_iapp_service_dbus_method_info[] = {&_steadyflow_iapp_service_dbus_method_info_add_file, &_steadyflow_iapp_service_dbus_method_info_set_visible, NULL};
static const GDBusSignalInfo * const _steadyflow_iapp_service_dbus_signal_info[] = {NULL};
static const GDBusPropertyInfo * const _steadyflow_iapp_service_dbus_property_info[] = {NULL};
static const GDBusInterfaceInfo _steadyflow_iapp_service_dbus_interface_info = {-1, "net.launchpad.steadyflow.App", (GDBusMethodInfo **) (&_steadyflow_iapp_service_dbus_method_info), (GDBusSignalInfo **) (&_steadyflow_iapp_service_dbus_signal_info), (GDBusPropertyInfo **) (&_steadyflow_iapp_service_dbus_property_info)};
static const GDBusInterfaceVTable _steadyflow_iapp_service_dbus_interface_vtable = {steadyflow_iapp_service_dbus_interface_method_call, steadyflow_iapp_service_dbus_interface_get_property, steadyflow_iapp_service_dbus_interface_set_property};

void steadyflow_iapp_service_add_file (SteadyflowIAppService* self, const gchar* url, GError** error) {
	g_return_if_fail (self != NULL);
	STEADYFLOW_IAPP_SERVICE_GET_INTERFACE (self)->add_file (self, url, error);
}


void steadyflow_iapp_service_set_visible (SteadyflowIAppService* self, gboolean visible, GError** error) {
	g_return_if_fail (self != NULL);
	STEADYFLOW_IAPP_SERVICE_GET_INTERFACE (self)->set_visible (self, visible, error);
}


static void steadyflow_iapp_service_base_init (SteadyflowIAppServiceIface * iface) {
	static gboolean initialized = FALSE;
	if (!initialized) {
		initialized = TRUE;
	}
}


GType steadyflow_iapp_service_get_type (void) {
	static volatile gsize steadyflow_iapp_service_type_id__volatile = 0;
	if (g_once_init_enter (&steadyflow_iapp_service_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (SteadyflowIAppServiceIface), (GBaseInitFunc) steadyflow_iapp_service_base_init, (GBaseFinalizeFunc) NULL, (GClassInitFunc) NULL, (GClassFinalizeFunc) NULL, NULL, 0, 0, (GInstanceInitFunc) NULL, NULL };
		GType steadyflow_iapp_service_type_id;
		steadyflow_iapp_service_type_id = g_type_register_static (G_TYPE_INTERFACE, "SteadyflowIAppService", &g_define_type_info, 0);
		g_type_interface_add_prerequisite (steadyflow_iapp_service_type_id, G_TYPE_OBJECT);
		g_type_set_qdata (steadyflow_iapp_service_type_id, g_quark_from_static_string ("vala-dbus-proxy-type"), (void*) steadyflow_iapp_service_proxy_get_type);
		g_type_set_qdata (steadyflow_iapp_service_type_id, g_quark_from_static_string ("vala-dbus-interface-name"), "net.launchpad.steadyflow.App");
		g_type_set_qdata (steadyflow_iapp_service_type_id, g_quark_from_static_string ("vala-dbus-register-object"), (void*) steadyflow_iapp_service_register_object);
		g_once_init_leave (&steadyflow_iapp_service_type_id__volatile, steadyflow_iapp_service_type_id);
	}
	return steadyflow_iapp_service_type_id__volatile;
}


G_DEFINE_TYPE_EXTENDED (SteadyflowIAppServiceProxy, steadyflow_iapp_service_proxy, G_TYPE_DBUS_PROXY, 0, G_IMPLEMENT_INTERFACE (STEADYFLOW_TYPE_IAPP_SERVICE, steadyflow_iapp_service_proxy_steadyflow_iapp_service_interface_init) )
static void steadyflow_iapp_service_proxy_class_init (SteadyflowIAppServiceProxyClass* klass) {
	G_DBUS_PROXY_CLASS (klass)->g_signal = steadyflow_iapp_service_proxy_g_signal;
}


static void steadyflow_iapp_service_proxy_g_signal (GDBusProxy* proxy, const gchar* sender_name, const gchar* signal_name, GVariant* parameters) {
}


static void steadyflow_iapp_service_proxy_init (SteadyflowIAppServiceProxy* self) {
}


static void steadyflow_iapp_service_proxy_add_file (SteadyflowIAppService* self, const gchar* url, GError** error) {
	GDBusMessage *_message;
	GVariant *_arguments;
	GVariantBuilder _arguments_builder;
	GDBusMessage *_reply_message;
	G_IO_ERROR;
	_message = g_dbus_message_new_method_call (g_dbus_proxy_get_name ((GDBusProxy *) self), g_dbus_proxy_get_object_path ((GDBusProxy *) self), "net.launchpad.steadyflow.App", "AddFile");
	g_variant_builder_init (&_arguments_builder, G_VARIANT_TYPE_TUPLE);
	g_variant_builder_add_value (&_arguments_builder, g_variant_new_string (url));
	_arguments = g_variant_builder_end (&_arguments_builder);
	g_dbus_message_set_body (_message, _arguments);
	_reply_message = g_dbus_connection_send_message_with_reply_sync (g_dbus_proxy_get_connection ((GDBusProxy *) self), _message, G_DBUS_SEND_MESSAGE_FLAGS_NONE, g_dbus_proxy_get_default_timeout ((GDBusProxy *) self), NULL, NULL, error);
	g_object_unref (_message);
	if (!_reply_message) {
		return;
	}
	if (g_dbus_message_to_gerror (_reply_message, error)) {
		g_object_unref (_reply_message);
		return;
	}
	g_object_unref (_reply_message);
}


static void steadyflow_iapp_service_proxy_set_visible (SteadyflowIAppService* self, gboolean visible, GError** error) {
	GDBusMessage *_message;
	GVariant *_arguments;
	GVariantBuilder _arguments_builder;
	GDBusMessage *_reply_message;
	G_IO_ERROR;
	_message = g_dbus_message_new_method_call (g_dbus_proxy_get_name ((GDBusProxy *) self), g_dbus_proxy_get_object_path ((GDBusProxy *) self), "net.launchpad.steadyflow.App", "SetVisible");
	g_variant_builder_init (&_arguments_builder, G_VARIANT_TYPE_TUPLE);
	g_variant_builder_add_value (&_arguments_builder, g_variant_new_boolean (visible));
	_arguments = g_variant_builder_end (&_arguments_builder);
	g_dbus_message_set_body (_message, _arguments);
	_reply_message = g_dbus_connection_send_message_with_reply_sync (g_dbus_proxy_get_connection ((GDBusProxy *) self), _message, G_DBUS_SEND_MESSAGE_FLAGS_NONE, g_dbus_proxy_get_default_timeout ((GDBusProxy *) self), NULL, NULL, error);
	g_object_unref (_message);
	if (!_reply_message) {
		return;
	}
	if (g_dbus_message_to_gerror (_reply_message, error)) {
		g_object_unref (_reply_message);
		return;
	}
	g_object_unref (_reply_message);
}


static void steadyflow_iapp_service_proxy_steadyflow_iapp_service_interface_init (SteadyflowIAppServiceIface* iface) {
	iface->add_file = steadyflow_iapp_service_proxy_add_file;
	iface->set_visible = steadyflow_iapp_service_proxy_set_visible;
}


static void _dbus_steadyflow_iapp_service_add_file (SteadyflowIAppService* self, GVariant* parameters, GDBusMethodInvocation* invocation) {
	GError* error = NULL;
	GVariantIter _arguments_iter;
	gchar* url = NULL;
	GVariant* _tmp0_;
	GDBusMessage* _reply_message;
	GVariant* _reply;
	GVariantBuilder _reply_builder;
	g_variant_iter_init (&_arguments_iter, parameters);
	_tmp0_ = g_variant_iter_next_value (&_arguments_iter);
	url = g_variant_dup_string (_tmp0_, NULL);
	g_variant_unref (_tmp0_);
	steadyflow_iapp_service_add_file (self, url, &error);
	if (error) {
		g_dbus_method_invocation_return_gerror (invocation, error);
		return;
	}
	_reply_message = g_dbus_message_new_method_reply (g_dbus_method_invocation_get_message (invocation));
	g_variant_builder_init (&_reply_builder, G_VARIANT_TYPE_TUPLE);
	_reply = g_variant_builder_end (&_reply_builder);
	g_dbus_message_set_body (_reply_message, _reply);
	_g_free0 (url);
	g_dbus_connection_send_message (g_dbus_method_invocation_get_connection (invocation), _reply_message, G_DBUS_SEND_MESSAGE_FLAGS_NONE, NULL, NULL);
	g_object_unref (invocation);
	g_object_unref (_reply_message);
}


static void _dbus_steadyflow_iapp_service_set_visible (SteadyflowIAppService* self, GVariant* parameters, GDBusMethodInvocation* invocation) {
	GError* error = NULL;
	GVariantIter _arguments_iter;
	gboolean visible = FALSE;
	GVariant* _tmp1_;
	GDBusMessage* _reply_message;
	GVariant* _reply;
	GVariantBuilder _reply_builder;
	g_variant_iter_init (&_arguments_iter, parameters);
	_tmp1_ = g_variant_iter_next_value (&_arguments_iter);
	visible = g_variant_get_boolean (_tmp1_);
	g_variant_unref (_tmp1_);
	steadyflow_iapp_service_set_visible (self, visible, &error);
	if (error) {
		g_dbus_method_invocation_return_gerror (invocation, error);
		return;
	}
	_reply_message = g_dbus_message_new_method_reply (g_dbus_method_invocation_get_message (invocation));
	g_variant_builder_init (&_reply_builder, G_VARIANT_TYPE_TUPLE);
	_reply = g_variant_builder_end (&_reply_builder);
	g_dbus_message_set_body (_reply_message, _reply);
	g_dbus_connection_send_message (g_dbus_method_invocation_get_connection (invocation), _reply_message, G_DBUS_SEND_MESSAGE_FLAGS_NONE, NULL, NULL);
	g_object_unref (invocation);
	g_object_unref (_reply_message);
}


static void steadyflow_iapp_service_dbus_interface_method_call (GDBusConnection* connection, const gchar* sender, const gchar* object_path, const gchar* interface_name, const gchar* method_name, GVariant* parameters, GDBusMethodInvocation* invocation, gpointer user_data) {
	gpointer* data;
	gpointer object;
	data = user_data;
	object = data[0];
	if (strcmp (method_name, "AddFile") == 0) {
		_dbus_steadyflow_iapp_service_add_file (object, parameters, invocation);
	} else if (strcmp (method_name, "SetVisible") == 0) {
		_dbus_steadyflow_iapp_service_set_visible (object, parameters, invocation);
	} else {
		g_object_unref (invocation);
	}
}


static GVariant* steadyflow_iapp_service_dbus_interface_get_property (GDBusConnection* connection, const gchar* sender, const gchar* object_path, const gchar* interface_name, const gchar* property_name, GError** error, gpointer user_data) {
	gpointer* data;
	gpointer object;
	data = user_data;
	object = data[0];
	return NULL;
}


static gboolean steadyflow_iapp_service_dbus_interface_set_property (GDBusConnection* connection, const gchar* sender, const gchar* object_path, const gchar* interface_name, const gchar* property_name, GVariant* value, GError** error, gpointer user_data) {
	gpointer* data;
	gpointer object;
	data = user_data;
	object = data[0];
	return FALSE;
}


guint steadyflow_iapp_service_register_object (gpointer object, GDBusConnection* connection, const gchar* path, GError** error) {
	guint result;
	gpointer *data;
	data = g_new (gpointer, 3);
	data[0] = g_object_ref (object);
	data[1] = g_object_ref (connection);
	data[2] = g_strdup (path);
	result = g_dbus_connection_register_object (connection, path, (GDBusInterfaceInfo *) (&_steadyflow_iapp_service_dbus_interface_info), &_steadyflow_iapp_service_dbus_interface_vtable, data, _steadyflow_iapp_service_unregister_object, error);
	if (!result) {
		return 0;
	}
	return result;
}


static void _steadyflow_iapp_service_unregister_object (gpointer user_data) {
	gpointer* data;
	data = user_data;
	g_object_unref (data[0]);
	g_object_unref (data[1]);
	g_free (data[2]);
	g_free (data);
}



