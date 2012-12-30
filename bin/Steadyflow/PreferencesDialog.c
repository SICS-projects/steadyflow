/* PreferencesDialog.c generated by valac 0.16.1, the Vala compiler
 * generated from PreferencesDialog.vala, do not modify */

/*
    PreferencesDialog.vala
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
#include <gee.h>
#include <stdlib.h>
#include <string.h>
#include <glib/gi18n-lib.h>


#define STEADYFLOW_UI_TYPE_IGTK_BUILDER_CONTAINER (steadyflow_ui_igtk_builder_container_get_type ())
#define STEADYFLOW_UI_IGTK_BUILDER_CONTAINER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_UI_TYPE_IGTK_BUILDER_CONTAINER, SteadyflowUIIGtkBuilderContainer))
#define STEADYFLOW_UI_IS_IGTK_BUILDER_CONTAINER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_UI_TYPE_IGTK_BUILDER_CONTAINER))
#define STEADYFLOW_UI_IGTK_BUILDER_CONTAINER_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), STEADYFLOW_UI_TYPE_IGTK_BUILDER_CONTAINER, SteadyflowUIIGtkBuilderContainerIface))

typedef struct _SteadyflowUIIGtkBuilderContainer SteadyflowUIIGtkBuilderContainer;
typedef struct _SteadyflowUIIGtkBuilderContainerIface SteadyflowUIIGtkBuilderContainerIface;

#define STEADYFLOW_UI_TYPE_GTK_BUILDER_DIALOG (steadyflow_ui_gtk_builder_dialog_get_type ())
#define STEADYFLOW_UI_GTK_BUILDER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_UI_TYPE_GTK_BUILDER_DIALOG, SteadyflowUIGtkBuilderDialog))
#define STEADYFLOW_UI_GTK_BUILDER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), STEADYFLOW_UI_TYPE_GTK_BUILDER_DIALOG, SteadyflowUIGtkBuilderDialogClass))
#define STEADYFLOW_UI_IS_GTK_BUILDER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_UI_TYPE_GTK_BUILDER_DIALOG))
#define STEADYFLOW_UI_IS_GTK_BUILDER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), STEADYFLOW_UI_TYPE_GTK_BUILDER_DIALOG))
#define STEADYFLOW_UI_GTK_BUILDER_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), STEADYFLOW_UI_TYPE_GTK_BUILDER_DIALOG, SteadyflowUIGtkBuilderDialogClass))

typedef struct _SteadyflowUIGtkBuilderDialog SteadyflowUIGtkBuilderDialog;
typedef struct _SteadyflowUIGtkBuilderDialogClass SteadyflowUIGtkBuilderDialogClass;
typedef struct _SteadyflowUIGtkBuilderDialogPrivate SteadyflowUIGtkBuilderDialogPrivate;

#define STEADYFLOW_TYPE_PREFERENCES_DIALOG (steadyflow_preferences_dialog_get_type ())
#define STEADYFLOW_PREFERENCES_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_TYPE_PREFERENCES_DIALOG, SteadyflowPreferencesDialog))
#define STEADYFLOW_PREFERENCES_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), STEADYFLOW_TYPE_PREFERENCES_DIALOG, SteadyflowPreferencesDialogClass))
#define STEADYFLOW_IS_PREFERENCES_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_TYPE_PREFERENCES_DIALOG))
#define STEADYFLOW_IS_PREFERENCES_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), STEADYFLOW_TYPE_PREFERENCES_DIALOG))
#define STEADYFLOW_PREFERENCES_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), STEADYFLOW_TYPE_PREFERENCES_DIALOG, SteadyflowPreferencesDialogClass))

typedef struct _SteadyflowPreferencesDialog SteadyflowPreferencesDialog;
typedef struct _SteadyflowPreferencesDialogClass SteadyflowPreferencesDialogClass;
typedef struct _SteadyflowPreferencesDialogPrivate SteadyflowPreferencesDialogPrivate;

#define STEADYFLOW_CORE_IDOWNLOAD_FILE_TYPE_FINISH_ACTION (steadyflow_core_idownload_file_finish_action_get_type ())
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_free0(var) (var = (g_free (var), NULL))

#define STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE (steadyflow_core_isettings_service_get_type ())
#define STEADYFLOW_CORE_ISETTINGS_SERVICE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE, SteadyflowCoreISettingsService))
#define STEADYFLOW_CORE_IS_ISETTINGS_SERVICE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE))
#define STEADYFLOW_CORE_ISETTINGS_SERVICE_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), STEADYFLOW_CORE_TYPE_ISETTINGS_SERVICE, SteadyflowCoreISettingsServiceIface))

typedef struct _SteadyflowCoreISettingsService SteadyflowCoreISettingsService;
typedef struct _SteadyflowCoreISettingsServiceIface SteadyflowCoreISettingsServiceIface;

struct _SteadyflowUIIGtkBuilderContainerIface {
	GTypeInterface parent_iface;
	GtkBuilder* (*get_builder) (SteadyflowUIIGtkBuilderContainer* self);
};

struct _SteadyflowUIGtkBuilderDialog {
	GtkDialog parent_instance;
	SteadyflowUIGtkBuilderDialogPrivate * priv;
};

struct _SteadyflowUIGtkBuilderDialogClass {
	GtkDialogClass parent_class;
};

struct _SteadyflowPreferencesDialog {
	SteadyflowUIGtkBuilderDialog parent_instance;
	SteadyflowPreferencesDialogPrivate * priv;
};

struct _SteadyflowPreferencesDialogClass {
	SteadyflowUIGtkBuilderDialogClass parent_class;
};

typedef enum  {
	STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_DO_NOTHING = 0,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_OPEN_FILE,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_OPEN_FOLDER,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_RUN_COMMAND
} SteadyflowCoreIDownloadFileFinishAction;

struct _SteadyflowPreferencesDialogPrivate {
	GeeMap* checkbutton_map;
	GeeMap* finish_action_map;
	GtkFileChooserButton* default_folder;
	GtkCheckButton* c_show_indicator;
	GtkCheckButton* c_show_notifications;
	GtkCheckButton* c_minimize_to_indicator;
	GtkCheckButton* c_start_minimized;
};

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


static gpointer steadyflow_preferences_dialog_parent_class = NULL;

GType steadyflow_ui_igtk_builder_container_get_type (void) G_GNUC_CONST;
GType steadyflow_ui_gtk_builder_dialog_get_type (void) G_GNUC_CONST;
GType steadyflow_preferences_dialog_get_type (void) G_GNUC_CONST;
GType steadyflow_core_idownload_file_finish_action_get_type (void) G_GNUC_CONST;
#define STEADYFLOW_PREFERENCES_DIALOG_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), STEADYFLOW_TYPE_PREFERENCES_DIALOG, SteadyflowPreferencesDialogPrivate))
enum  {
	STEADYFLOW_PREFERENCES_DIALOG_DUMMY_PROPERTY
};
SteadyflowPreferencesDialog* steadyflow_preferences_dialog_new (GtkWindow* parent);
SteadyflowPreferencesDialog* steadyflow_preferences_dialog_construct (GType object_type, GtkWindow* parent);
SteadyflowUIGtkBuilderDialog* steadyflow_ui_gtk_builder_dialog_construct (GType object_type, const gchar* file_id, GtkWindow* parent, gboolean modal);
GObject* steadyflow_ui_igtk_builder_container_get_object (SteadyflowUIIGtkBuilderContainer* self, const gchar* id);
static void steadyflow_preferences_dialog_load_settings (SteadyflowPreferencesDialog* self);
void steadyflow_ui_igtk_builder_container_autoconnect (SteadyflowUIIGtkBuilderContainer* self);
gchar* steadyflow_services_get_default_download_folder (void);
GType steadyflow_core_isettings_service_get_type (void) G_GNUC_CONST;
SteadyflowCoreISettingsService* steadyflow_services_get_settings (void);
gboolean steadyflow_core_isettings_service_get_boolean (SteadyflowCoreISettingsService* self, const gchar* key);
void steadyflow_preferences_dialog_on_show_indicator_toggled (GtkCheckButton* sender, SteadyflowPreferencesDialog* self);
static void steadyflow_preferences_dialog_register_finish_action (SteadyflowPreferencesDialog* self, GtkRadioButton* button, SteadyflowCoreIDownloadFileFinishAction action);
gint steadyflow_core_isettings_service_get_enum (SteadyflowCoreISettingsService* self, const gchar* key);
void steadyflow_preferences_dialog_on_default_folder_changed (GtkFileChooserButton* sender, SteadyflowPreferencesDialog* self);
void steadyflow_core_isettings_service_set_string (SteadyflowCoreISettingsService* self, const gchar* key, const gchar* value);
void steadyflow_preferences_dialog_on_checkbox_toggled (GtkCheckButton* sender, SteadyflowPreferencesDialog* self);
void steadyflow_core_isettings_service_set_boolean (SteadyflowCoreISettingsService* self, const gchar* key, gboolean value);
void steadyflow_preferences_dialog_on_finish_action_toggled (GtkRadioButton* sender, SteadyflowPreferencesDialog* self);
void steadyflow_core_isettings_service_set_enum (SteadyflowCoreISettingsService* self, const gchar* key, gint value);
static void steadyflow_preferences_dialog_finalize (GObject* obj);


SteadyflowPreferencesDialog* steadyflow_preferences_dialog_construct (GType object_type, GtkWindow* parent) {
	SteadyflowPreferencesDialog * self = NULL;
	GtkWindow* _tmp0_;
	const gchar* _tmp1_ = NULL;
	GtkBox* _tmp2_ = NULL;
	GObject* _tmp3_ = NULL;
	GeeHashMap* _tmp4_;
	GeeMap* _tmp5_;
	GObject* _tmp6_ = NULL;
	GtkCheckButton* _tmp7_;
	GeeMap* _tmp8_;
	GObject* _tmp9_ = NULL;
	GtkCheckButton* _tmp10_;
	GeeMap* _tmp11_;
	GObject* _tmp12_ = NULL;
	GtkCheckButton* _tmp13_;
	GeeMap* _tmp14_;
	GObject* _tmp15_ = NULL;
	GtkCheckButton* _tmp16_;
	GeeHashMap* _tmp17_;
	g_return_val_if_fail (parent != NULL, NULL);
	_tmp0_ = parent;
	self = (SteadyflowPreferencesDialog*) steadyflow_ui_gtk_builder_dialog_construct (object_type, "PreferencesDialog", _tmp0_, TRUE);
	_tmp1_ = _ ("Steadyflow Preferences");
	gtk_window_set_title ((GtkWindow*) self, _tmp1_);
	gtk_container_set_border_width ((GtkContainer*) self, (guint) 5);
	gtk_window_set_resizable ((GtkWindow*) self, FALSE);
	_tmp2_ = gtk_dialog_get_content_area ((GtkDialog*) self);
	gtk_box_set_spacing (GTK_IS_BOX (_tmp2_) ? ((GtkBox*) _tmp2_) : NULL, 2);
	_tmp3_ = steadyflow_ui_igtk_builder_container_get_object ((SteadyflowUIIGtkBuilderContainer*) self, "default_folder");
	_g_object_unref0 (self->priv->default_folder);
	self->priv->default_folder = GTK_FILE_CHOOSER_BUTTON (_tmp3_);
	_tmp4_ = gee_hash_map_new (GTK_TYPE_CHECK_BUTTON, (GBoxedCopyFunc) g_object_ref, g_object_unref, G_TYPE_STRING, (GBoxedCopyFunc) g_strdup, g_free, NULL, NULL, NULL);
	_g_object_unref0 (self->priv->checkbutton_map);
	self->priv->checkbutton_map = (GeeMap*) _tmp4_;
	_tmp5_ = self->priv->checkbutton_map;
	_tmp6_ = steadyflow_ui_igtk_builder_container_get_object ((SteadyflowUIIGtkBuilderContainer*) self, "c_show_indicator");
	_g_object_unref0 (self->priv->c_show_indicator);
	self->priv->c_show_indicator = GTK_CHECK_BUTTON (_tmp6_);
	_tmp7_ = self->priv->c_show_indicator;
	gee_map_set (_tmp5_, _tmp7_, "show-indicator");
	_tmp8_ = self->priv->checkbutton_map;
	_tmp9_ = steadyflow_ui_igtk_builder_container_get_object ((SteadyflowUIIGtkBuilderContainer*) self, "c_show_notifications");
	_g_object_unref0 (self->priv->c_show_notifications);
	self->priv->c_show_notifications = GTK_CHECK_BUTTON (_tmp9_);
	_tmp10_ = self->priv->c_show_notifications;
	gee_map_set (_tmp8_, _tmp10_, "show-notifications");
	_tmp11_ = self->priv->checkbutton_map;
	_tmp12_ = steadyflow_ui_igtk_builder_container_get_object ((SteadyflowUIIGtkBuilderContainer*) self, "c_minimize_to_indicator");
	_g_object_unref0 (self->priv->c_minimize_to_indicator);
	self->priv->c_minimize_to_indicator = GTK_CHECK_BUTTON (_tmp12_);
	_tmp13_ = self->priv->c_minimize_to_indicator;
	gee_map_set (_tmp11_, _tmp13_, "minimize-to-indicator");
	_tmp14_ = self->priv->checkbutton_map;
	_tmp15_ = steadyflow_ui_igtk_builder_container_get_object ((SteadyflowUIIGtkBuilderContainer*) self, "c_start_minimized");
	_g_object_unref0 (self->priv->c_start_minimized);
	self->priv->c_start_minimized = GTK_CHECK_BUTTON (_tmp15_);
	_tmp16_ = self->priv->c_start_minimized;
	gee_map_set (_tmp14_, _tmp16_, "start-minimized");
	_tmp17_ = gee_hash_map_new (GTK_TYPE_RADIO_BUTTON, (GBoxedCopyFunc) g_object_ref, g_object_unref, STEADYFLOW_CORE_IDOWNLOAD_FILE_TYPE_FINISH_ACTION, NULL, NULL, NULL, NULL, NULL);
	_g_object_unref0 (self->priv->finish_action_map);
	self->priv->finish_action_map = (GeeMap*) _tmp17_;
	steadyflow_preferences_dialog_load_settings (self);
	gtk_dialog_add_button ((GtkDialog*) self, GTK_STOCK_CLOSE, (gint) GTK_RESPONSE_CLOSE);
	steadyflow_ui_igtk_builder_container_autoconnect ((SteadyflowUIIGtkBuilderContainer*) self);
	return self;
}


SteadyflowPreferencesDialog* steadyflow_preferences_dialog_new (GtkWindow* parent) {
	return steadyflow_preferences_dialog_construct (STEADYFLOW_TYPE_PREFERENCES_DIALOG, parent);
}


static void steadyflow_preferences_dialog_load_settings (SteadyflowPreferencesDialog* self) {
	GtkFileChooserButton* _tmp0_;
	gchar* _tmp1_ = NULL;
	gchar* _tmp2_;
	GtkCheckButton* _tmp21_;
	GObject* _tmp22_ = NULL;
	GtkRadioButton* _tmp23_;
	GObject* _tmp24_ = NULL;
	GtkRadioButton* _tmp25_;
	GObject* _tmp26_ = NULL;
	GtkRadioButton* _tmp27_;
	g_return_if_fail (self != NULL);
	_tmp0_ = self->priv->default_folder;
	_tmp1_ = steadyflow_services_get_default_download_folder ();
	_tmp2_ = _tmp1_;
	gtk_file_chooser_set_current_folder ((GtkFileChooser*) _tmp0_, _tmp2_);
	_g_free0 (_tmp2_);
	{
		GeeMap* _tmp3_;
		GeeSet* _tmp4_;
		GeeSet* _tmp5_;
		GeeSet* _tmp6_;
		GeeIterator* _tmp7_ = NULL;
		GeeIterator* _tmp8_;
		GeeIterator* _cb_it;
		_tmp3_ = self->priv->checkbutton_map;
		_tmp4_ = gee_map_get_keys (_tmp3_);
		_tmp5_ = _tmp4_;
		_tmp6_ = _tmp5_;
		_tmp7_ = gee_iterable_iterator ((GeeIterable*) _tmp6_);
		_tmp8_ = _tmp7_;
		_g_object_unref0 (_tmp6_);
		_cb_it = _tmp8_;
		while (TRUE) {
			GeeIterator* _tmp9_;
			gboolean _tmp10_ = FALSE;
			GeeIterator* _tmp11_;
			gpointer _tmp12_ = NULL;
			GtkCheckButton* cb;
			GtkCheckButton* _tmp13_;
			SteadyflowCoreISettingsService* _tmp14_;
			SteadyflowCoreISettingsService* _tmp15_;
			GeeMap* _tmp16_;
			GtkCheckButton* _tmp17_;
			gpointer _tmp18_ = NULL;
			gchar* _tmp19_;
			gboolean _tmp20_ = FALSE;
			_tmp9_ = _cb_it;
			_tmp10_ = gee_iterator_next (_tmp9_);
			if (!_tmp10_) {
				break;
			}
			_tmp11_ = _cb_it;
			_tmp12_ = gee_iterator_get (_tmp11_);
			cb = (GtkCheckButton*) _tmp12_;
			_tmp13_ = cb;
			_tmp14_ = steadyflow_services_get_settings ();
			_tmp15_ = _tmp14_;
			_tmp16_ = self->priv->checkbutton_map;
			_tmp17_ = cb;
			_tmp18_ = gee_map_get (_tmp16_, _tmp17_);
			_tmp19_ = (gchar*) _tmp18_;
			_tmp20_ = steadyflow_core_isettings_service_get_boolean (_tmp15_, _tmp19_);
			gtk_toggle_button_set_active ((GtkToggleButton*) _tmp13_, _tmp20_);
			_g_free0 (_tmp19_);
			_g_object_unref0 (cb);
		}
		_g_object_unref0 (_cb_it);
	}
	_tmp21_ = self->priv->c_show_indicator;
	steadyflow_preferences_dialog_on_show_indicator_toggled (_tmp21_, self);
	_tmp22_ = steadyflow_ui_igtk_builder_container_get_object ((SteadyflowUIIGtkBuilderContainer*) self, "r_donothing");
	_tmp23_ = GTK_RADIO_BUTTON (_tmp22_);
	steadyflow_preferences_dialog_register_finish_action (self, _tmp23_, STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_DO_NOTHING);
	_g_object_unref0 (_tmp23_);
	_tmp24_ = steadyflow_ui_igtk_builder_container_get_object ((SteadyflowUIIGtkBuilderContainer*) self, "r_openfile");
	_tmp25_ = GTK_RADIO_BUTTON (_tmp24_);
	steadyflow_preferences_dialog_register_finish_action (self, _tmp25_, STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_OPEN_FILE);
	_g_object_unref0 (_tmp25_);
	_tmp26_ = steadyflow_ui_igtk_builder_container_get_object ((SteadyflowUIIGtkBuilderContainer*) self, "r_openfolder");
	_tmp27_ = GTK_RADIO_BUTTON (_tmp26_);
	steadyflow_preferences_dialog_register_finish_action (self, _tmp27_, STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_OPEN_FOLDER);
	_g_object_unref0 (_tmp27_);
}


static void steadyflow_preferences_dialog_register_finish_action (SteadyflowPreferencesDialog* self, GtkRadioButton* button, SteadyflowCoreIDownloadFileFinishAction action) {
	GeeMap* _tmp0_;
	GtkRadioButton* _tmp1_;
	SteadyflowCoreIDownloadFileFinishAction _tmp2_;
	SteadyflowCoreISettingsService* _tmp3_;
	SteadyflowCoreISettingsService* _tmp4_;
	gint _tmp5_ = 0;
	SteadyflowCoreIDownloadFileFinishAction _tmp6_;
	g_return_if_fail (self != NULL);
	g_return_if_fail (button != NULL);
	_tmp0_ = self->priv->finish_action_map;
	_tmp1_ = button;
	_tmp2_ = action;
	gee_map_set (_tmp0_, _tmp1_, GINT_TO_POINTER (_tmp2_));
	_tmp3_ = steadyflow_services_get_settings ();
	_tmp4_ = _tmp3_;
	_tmp5_ = steadyflow_core_isettings_service_get_enum (_tmp4_, "default-post-download-action");
	_tmp6_ = action;
	if (_tmp5_ == ((gint) _tmp6_)) {
		GtkRadioButton* _tmp7_;
		_tmp7_ = button;
		gtk_toggle_button_set_active ((GtkToggleButton*) _tmp7_, TRUE);
	}
}


void steadyflow_preferences_dialog_on_default_folder_changed (GtkFileChooserButton* sender, SteadyflowPreferencesDialog* self) {
	SteadyflowCoreISettingsService* _tmp0_;
	SteadyflowCoreISettingsService* _tmp1_;
	GtkFileChooserButton* _tmp2_;
	gchar* _tmp3_ = NULL;
	gchar* _tmp4_;
	g_return_if_fail (self != NULL);
	g_return_if_fail (sender != NULL);
	_tmp0_ = steadyflow_services_get_settings ();
	_tmp1_ = _tmp0_;
	_tmp2_ = sender;
	_tmp3_ = gtk_file_chooser_get_current_folder ((GtkFileChooser*) _tmp2_);
	_tmp4_ = _tmp3_;
	steadyflow_core_isettings_service_set_string (_tmp1_, "default-download-folder", _tmp4_);
	_g_free0 (_tmp4_);
}


void steadyflow_preferences_dialog_on_checkbox_toggled (GtkCheckButton* sender, SteadyflowPreferencesDialog* self) {
	SteadyflowCoreISettingsService* _tmp0_;
	SteadyflowCoreISettingsService* _tmp1_;
	GeeMap* _tmp2_;
	GtkCheckButton* _tmp3_;
	gpointer _tmp4_ = NULL;
	gchar* _tmp5_;
	GtkCheckButton* _tmp6_;
	gboolean _tmp7_;
	gboolean _tmp8_;
	g_return_if_fail (self != NULL);
	g_return_if_fail (sender != NULL);
	_tmp0_ = steadyflow_services_get_settings ();
	_tmp1_ = _tmp0_;
	_tmp2_ = self->priv->checkbutton_map;
	_tmp3_ = sender;
	_tmp4_ = gee_map_get (_tmp2_, _tmp3_);
	_tmp5_ = (gchar*) _tmp4_;
	_tmp6_ = sender;
	_tmp7_ = gtk_toggle_button_get_active ((GtkToggleButton*) _tmp6_);
	_tmp8_ = _tmp7_;
	steadyflow_core_isettings_service_set_boolean (_tmp1_, _tmp5_, _tmp8_);
	_g_free0 (_tmp5_);
}


void steadyflow_preferences_dialog_on_finish_action_toggled (GtkRadioButton* sender, SteadyflowPreferencesDialog* self) {
	SteadyflowCoreISettingsService* _tmp0_;
	SteadyflowCoreISettingsService* _tmp1_;
	GeeMap* _tmp2_;
	GtkRadioButton* _tmp3_;
	gpointer _tmp4_ = NULL;
	g_return_if_fail (self != NULL);
	g_return_if_fail (sender != NULL);
	_tmp0_ = steadyflow_services_get_settings ();
	_tmp1_ = _tmp0_;
	_tmp2_ = self->priv->finish_action_map;
	_tmp3_ = sender;
	_tmp4_ = gee_map_get (_tmp2_, _tmp3_);
	steadyflow_core_isettings_service_set_enum (_tmp1_, "default-post-download-action", (gint) GPOINTER_TO_INT (_tmp4_));
}


void steadyflow_preferences_dialog_on_show_indicator_toggled (GtkCheckButton* sender, SteadyflowPreferencesDialog* self) {
	GtkCheckButton* _tmp0_;
	gboolean _tmp1_;
	gboolean _tmp2_;
	gboolean active;
	SteadyflowCoreISettingsService* _tmp3_;
	SteadyflowCoreISettingsService* _tmp4_;
	GtkCheckButton* _tmp5_;
	GtkCheckButton* _tmp6_;
	g_return_if_fail (self != NULL);
	g_return_if_fail (sender != NULL);
	_tmp0_ = sender;
	_tmp1_ = gtk_toggle_button_get_active ((GtkToggleButton*) _tmp0_);
	_tmp2_ = _tmp1_;
	active = _tmp2_;
	_tmp3_ = steadyflow_services_get_settings ();
	_tmp4_ = _tmp3_;
	steadyflow_core_isettings_service_set_boolean (_tmp4_, "show-indicator", active);
	_tmp5_ = self->priv->c_minimize_to_indicator;
	gtk_widget_set_sensitive ((GtkWidget*) _tmp5_, active);
	_tmp6_ = self->priv->c_start_minimized;
	gtk_widget_set_sensitive ((GtkWidget*) _tmp6_, active);
}


static void steadyflow_preferences_dialog_class_init (SteadyflowPreferencesDialogClass * klass) {
	steadyflow_preferences_dialog_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (SteadyflowPreferencesDialogPrivate));
	G_OBJECT_CLASS (klass)->finalize = steadyflow_preferences_dialog_finalize;
}


static void steadyflow_preferences_dialog_instance_init (SteadyflowPreferencesDialog * self) {
	self->priv = STEADYFLOW_PREFERENCES_DIALOG_GET_PRIVATE (self);
}


static void steadyflow_preferences_dialog_finalize (GObject* obj) {
	SteadyflowPreferencesDialog * self;
	self = STEADYFLOW_PREFERENCES_DIALOG (obj);
	_g_object_unref0 (self->priv->checkbutton_map);
	_g_object_unref0 (self->priv->finish_action_map);
	_g_object_unref0 (self->priv->default_folder);
	_g_object_unref0 (self->priv->c_show_indicator);
	_g_object_unref0 (self->priv->c_show_notifications);
	_g_object_unref0 (self->priv->c_minimize_to_indicator);
	_g_object_unref0 (self->priv->c_start_minimized);
	G_OBJECT_CLASS (steadyflow_preferences_dialog_parent_class)->finalize (obj);
}


GType steadyflow_preferences_dialog_get_type (void) {
	static volatile gsize steadyflow_preferences_dialog_type_id__volatile = 0;
	if (g_once_init_enter (&steadyflow_preferences_dialog_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (SteadyflowPreferencesDialogClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) steadyflow_preferences_dialog_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (SteadyflowPreferencesDialog), 0, (GInstanceInitFunc) steadyflow_preferences_dialog_instance_init, NULL };
		GType steadyflow_preferences_dialog_type_id;
		steadyflow_preferences_dialog_type_id = g_type_register_static (STEADYFLOW_UI_TYPE_GTK_BUILDER_DIALOG, "SteadyflowPreferencesDialog", &g_define_type_info, 0);
		g_once_init_leave (&steadyflow_preferences_dialog_type_id__volatile, steadyflow_preferences_dialog_type_id);
	}
	return steadyflow_preferences_dialog_type_id__volatile;
}


