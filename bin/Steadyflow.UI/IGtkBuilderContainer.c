/* IGtkBuilderContainer.c generated by valac 0.16.1, the Vala compiler
 * generated from IGtkBuilderContainer.vala, do not modify */

/*
    IGtkBuilderContainer.vala
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
#include <gtk/gtk.h>
#include <stdlib.h>
#include <string.h>
#include <glib/gi18n-lib.h>


#define STEADYFLOW_UI_TYPE_IGTK_BUILDER_CONTAINER (steadyflow_ui_igtk_builder_container_get_type ())
#define STEADYFLOW_UI_IGTK_BUILDER_CONTAINER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_UI_TYPE_IGTK_BUILDER_CONTAINER, SteadyflowUIIGtkBuilderContainer))
#define STEADYFLOW_UI_IS_IGTK_BUILDER_CONTAINER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_UI_TYPE_IGTK_BUILDER_CONTAINER))
#define STEADYFLOW_UI_IGTK_BUILDER_CONTAINER_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), STEADYFLOW_UI_TYPE_IGTK_BUILDER_CONTAINER, SteadyflowUIIGtkBuilderContainerIface))

typedef struct _SteadyflowUIIGtkBuilderContainer SteadyflowUIIGtkBuilderContainer;
typedef struct _SteadyflowUIIGtkBuilderContainerIface SteadyflowUIIGtkBuilderContainerIface;
#define _g_free0(var) (var = (g_free (var), NULL))
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_error_free0(var) ((var == NULL) ? NULL : (var = (g_error_free (var), NULL)))

struct _SteadyflowUIIGtkBuilderContainerIface {
	GTypeInterface parent_iface;
	GtkBuilder* (*get_builder) (SteadyflowUIIGtkBuilderContainer* self);
};



GType steadyflow_ui_igtk_builder_container_get_type (void) G_GNUC_CONST;
GtkBuilder* steadyflow_ui_igtk_builder_container_get_builder (SteadyflowUIIGtkBuilderContainer* self);
static GtkBuilder* steadyflow_ui_igtk_builder_container_resolve (const gchar* file_id, GError** error);
gchar* steadyflow_core_util_resolve_path (const gchar* rel_path);
GtkBuilder* steadyflow_ui_igtk_builder_container_init_builder (SteadyflowUIIGtkBuilderContainer* self, GtkContainer* container, const gchar* file_id);
void steadyflow_core_util_fatal_error (GError* e, const gchar* message);
void steadyflow_ui_igtk_builder_container_autoconnect (SteadyflowUIIGtkBuilderContainer* self);
GObject* steadyflow_ui_igtk_builder_container_get_object (SteadyflowUIIGtkBuilderContainer* self, const gchar* id);


GtkBuilder* steadyflow_ui_igtk_builder_container_get_builder (SteadyflowUIIGtkBuilderContainer* self) {
	g_return_val_if_fail (self != NULL, NULL);
	return STEADYFLOW_UI_IGTK_BUILDER_CONTAINER_GET_INTERFACE (self)->get_builder (self);
}


static GtkBuilder* steadyflow_ui_igtk_builder_container_resolve (const gchar* file_id, GError** error) {
	GtkBuilder* result = NULL;
	const gchar* _tmp0_;
	gchar* _tmp1_;
	gchar* _tmp2_;
	gchar* _tmp3_;
	gchar* _tmp4_;
	gchar* _tmp5_ = NULL;
	gchar* _tmp6_;
	gchar* file_name;
	GtkBuilder* _tmp7_;
	GtkBuilder* builder;
	GError * _inner_error_ = NULL;
	g_return_val_if_fail (file_id != NULL, NULL);
	_tmp0_ = file_id;
	_tmp1_ = g_strconcat ("ui/", _tmp0_, NULL);
	_tmp2_ = _tmp1_;
	_tmp3_ = g_strconcat (_tmp2_, ".ui", NULL);
	_tmp4_ = _tmp3_;
	_tmp5_ = steadyflow_core_util_resolve_path (_tmp4_);
	_tmp6_ = _tmp5_;
	_g_free0 (_tmp4_);
	_g_free0 (_tmp2_);
	file_name = _tmp6_;
	_tmp7_ = gtk_builder_new ();
	builder = _tmp7_;
	gtk_builder_add_from_file (builder, file_name, &_inner_error_);
	if (_inner_error_ != NULL) {
		g_propagate_error (error, _inner_error_);
		_g_object_unref0 (builder);
		_g_free0 (file_name);
		return NULL;
	}
	result = builder;
	_g_free0 (file_name);
	return result;
}


GtkBuilder* steadyflow_ui_igtk_builder_container_init_builder (SteadyflowUIIGtkBuilderContainer* self, GtkContainer* container, const gchar* file_id) {
	GtkBuilder* result = NULL;
	GError * _inner_error_ = NULL;
	g_return_val_if_fail (container != NULL, NULL);
	g_return_val_if_fail (file_id != NULL, NULL);
	{
		const gchar* _tmp0_;
		GtkBuilder* _tmp1_ = NULL;
		GtkBuilder* builder;
		GtkContainer* _tmp2_;
		GObject* _tmp3_ = NULL;
		_tmp0_ = file_id;
		_tmp1_ = steadyflow_ui_igtk_builder_container_resolve (_tmp0_, &_inner_error_);
		builder = _tmp1_;
		if (_inner_error_ != NULL) {
			goto __catch9_g_error;
		}
		_tmp2_ = container;
		_tmp3_ = gtk_builder_get_object (builder, "_window_content");
		gtk_container_add (_tmp2_, GTK_WIDGET (_tmp3_));
		result = builder;
		return result;
	}
	goto __finally9;
	__catch9_g_error:
	{
		GError* e = NULL;
		const gchar* _tmp4_ = NULL;
		const gchar* _tmp5_;
		gchar* _tmp6_ = NULL;
		gchar* _tmp7_;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp4_ = _ ("Cannot find XML definition file for window %s");
		_tmp5_ = file_id;
		_tmp6_ = g_strdup_printf (_tmp4_, _tmp5_);
		_tmp7_ = _tmp6_;
		steadyflow_core_util_fatal_error (e, _tmp7_);
		_g_free0 (_tmp7_);
		_g_error_free0 (e);
	}
	__finally9:
	g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
	g_clear_error (&_inner_error_);
	return NULL;
}


void steadyflow_ui_igtk_builder_container_autoconnect (SteadyflowUIIGtkBuilderContainer* self) {
	GtkBuilder* _tmp0_ = NULL;
	GtkBuilder* _tmp1_;
	_tmp0_ = steadyflow_ui_igtk_builder_container_get_builder (self);
	_tmp1_ = _tmp0_;
	gtk_builder_connect_signals (_tmp1_, self);
	_g_object_unref0 (_tmp1_);
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


GObject* steadyflow_ui_igtk_builder_container_get_object (SteadyflowUIIGtkBuilderContainer* self, const gchar* id) {
	GObject* result = NULL;
	GtkBuilder* _tmp0_ = NULL;
	GtkBuilder* _tmp1_;
	const gchar* _tmp2_;
	GObject* _tmp3_ = NULL;
	GObject* _tmp4_;
	GObject* _tmp5_;
	g_return_val_if_fail (id != NULL, NULL);
	_tmp0_ = steadyflow_ui_igtk_builder_container_get_builder (self);
	_tmp1_ = _tmp0_;
	_tmp2_ = id;
	_tmp3_ = gtk_builder_get_object (_tmp1_, _tmp2_);
	_tmp4_ = _g_object_ref0 (_tmp3_);
	_tmp5_ = _tmp4_;
	_g_object_unref0 (_tmp1_);
	result = _tmp5_;
	return result;
}


static void steadyflow_ui_igtk_builder_container_base_init (SteadyflowUIIGtkBuilderContainerIface * iface) {
	static gboolean initialized = FALSE;
	if (!initialized) {
		initialized = TRUE;
	}
}


GType steadyflow_ui_igtk_builder_container_get_type (void) {
	static volatile gsize steadyflow_ui_igtk_builder_container_type_id__volatile = 0;
	if (g_once_init_enter (&steadyflow_ui_igtk_builder_container_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (SteadyflowUIIGtkBuilderContainerIface), (GBaseInitFunc) steadyflow_ui_igtk_builder_container_base_init, (GBaseFinalizeFunc) NULL, (GClassInitFunc) NULL, (GClassFinalizeFunc) NULL, NULL, 0, 0, (GInstanceInitFunc) NULL, NULL };
		GType steadyflow_ui_igtk_builder_container_type_id;
		steadyflow_ui_igtk_builder_container_type_id = g_type_register_static (G_TYPE_INTERFACE, "SteadyflowUIIGtkBuilderContainer", &g_define_type_info, 0);
		g_once_init_leave (&steadyflow_ui_igtk_builder_container_type_id__volatile, steadyflow_ui_igtk_builder_container_type_id);
	}
	return steadyflow_ui_igtk_builder_container_type_id__volatile;
}



