/* UIUtil.c generated by valac 0.16.1, the Vala compiler
 * generated from UIUtil.vala, do not modify */

/*
    UIUtil.vala
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
#include <gio/gio.h>
#include <gtk/gtk.h>
#include <gdk/gdk.h>
#include <stdio.h>
#include <glib/gi18n-lib.h>


#define STEADYFLOW_UI_TYPE_UI_UTIL (steadyflow_ui_ui_util_get_type ())
#define STEADYFLOW_UI_UI_UTIL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_UI_TYPE_UI_UTIL, SteadyflowUIUIUtil))
#define STEADYFLOW_UI_UI_UTIL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), STEADYFLOW_UI_TYPE_UI_UTIL, SteadyflowUIUIUtilClass))
#define STEADYFLOW_UI_IS_UI_UTIL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_UI_TYPE_UI_UTIL))
#define STEADYFLOW_UI_IS_UI_UTIL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), STEADYFLOW_UI_TYPE_UI_UTIL))
#define STEADYFLOW_UI_UI_UTIL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), STEADYFLOW_UI_TYPE_UI_UTIL, SteadyflowUIUIUtilClass))

typedef struct _SteadyflowUIUIUtil SteadyflowUIUIUtil;
typedef struct _SteadyflowUIUIUtilClass SteadyflowUIUIUtilClass;
typedef struct _SteadyflowUIUIUtilPrivate SteadyflowUIUIUtilPrivate;

#define STEADYFLOW_CORE_TYPE_IDOWNLOAD_FILE (steadyflow_core_idownload_file_get_type ())
#define STEADYFLOW_CORE_IDOWNLOAD_FILE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STEADYFLOW_CORE_TYPE_IDOWNLOAD_FILE, SteadyflowCoreIDownloadFile))
#define STEADYFLOW_CORE_IS_IDOWNLOAD_FILE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STEADYFLOW_CORE_TYPE_IDOWNLOAD_FILE))
#define STEADYFLOW_CORE_IDOWNLOAD_FILE_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), STEADYFLOW_CORE_TYPE_IDOWNLOAD_FILE, SteadyflowCoreIDownloadFileIface))

typedef struct _SteadyflowCoreIDownloadFile SteadyflowCoreIDownloadFile;
typedef struct _SteadyflowCoreIDownloadFileIface SteadyflowCoreIDownloadFileIface;

#define STEADYFLOW_CORE_IDOWNLOAD_FILE_TYPE_STATUS (steadyflow_core_idownload_file_status_get_type ())

#define STEADYFLOW_CORE_IDOWNLOAD_FILE_TYPE_FINISH_ACTION (steadyflow_core_idownload_file_finish_action_get_type ())
#define _g_free0(var) (var = (g_free (var), NULL))
#define _g_error_free0(var) ((var == NULL) ? NULL : (var = (g_error_free (var), NULL)))
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
typedef struct _Block2Data Block2Data;

struct _SteadyflowUIUIUtil {
	GObject parent_instance;
	SteadyflowUIUIUtilPrivate * priv;
};

struct _SteadyflowUIUIUtilClass {
	GObjectClass parent_class;
};

typedef enum  {
	STEADYFLOW_CORE_IDOWNLOAD_FILE_STATUS_CONNECTING = 0,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_STATUS_DOWNLOADING,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_STATUS_PAUSED,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_STATUS_FINISHED,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_STATUS_NETWORK_ERROR
} SteadyflowCoreIDownloadFileStatus;

typedef enum  {
	STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_DO_NOTHING = 0,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_OPEN_FILE,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_OPEN_FOLDER,
	STEADYFLOW_CORE_IDOWNLOAD_FILE_FINISH_ACTION_RUN_COMMAND
} SteadyflowCoreIDownloadFileFinishAction;

struct _SteadyflowCoreIDownloadFileIface {
	GTypeInterface parent_iface;
	void (*start) (SteadyflowCoreIDownloadFile* self, gboolean resume);
	void (*pause) (SteadyflowCoreIDownloadFile* self);
	void (*serialize) (SteadyflowCoreIDownloadFile* self, GKeyFile* file);
	SteadyflowCoreIDownloadFileStatus (*get_status) (SteadyflowCoreIDownloadFile* self);
	gint (*get_uid) (SteadyflowCoreIDownloadFile* self);
	const gchar* (*get_url) (SteadyflowCoreIDownloadFile* self);
	const gchar* (*get_local_name) (SteadyflowCoreIDownloadFile* self);
	const gchar* (*get_local_basename) (SteadyflowCoreIDownloadFile* self);
	gint64 (*get_size) (SteadyflowCoreIDownloadFile* self);
	gint64 (*get_downloaded_size) (SteadyflowCoreIDownloadFile* self);
	gint (*get_speed) (SteadyflowCoreIDownloadFile* self);
	const gchar* (*get_icon_name) (SteadyflowCoreIDownloadFile* self);
	SteadyflowCoreIDownloadFileFinishAction (*get_finish_action) (SteadyflowCoreIDownloadFile* self);
	const gchar* (*get_finish_command) (SteadyflowCoreIDownloadFile* self);
	GError* (*get_error) (SteadyflowCoreIDownloadFile* self);
};

struct _Block2Data {
	int _ref_count_;
	GtkEntry* entry;
};


static gpointer steadyflow_ui_ui_util_parent_class = NULL;

GType steadyflow_ui_ui_util_get_type (void) G_GNUC_CONST;
enum  {
	STEADYFLOW_UI_UI_UTIL_DUMMY_PROPERTY
};
#define STEADYFLOW_UI_UI_UTIL_MESSAGE_FORMAT "<span weight='bold' size='larger'>%s</span>\n\n%s\n"
static SteadyflowUIUIUtil* steadyflow_ui_ui_util_new (void);
static SteadyflowUIUIUtil* steadyflow_ui_ui_util_construct (GType object_type);
GType steadyflow_core_idownload_file_status_get_type (void) G_GNUC_CONST;
GType steadyflow_core_idownload_file_finish_action_get_type (void) G_GNUC_CONST;
GType steadyflow_core_idownload_file_get_type (void) G_GNUC_CONST;
void steadyflow_ui_ui_util_open_file (SteadyflowCoreIDownloadFile* file);
const gchar* steadyflow_core_idownload_file_get_local_name (SteadyflowCoreIDownloadFile* self);
void steadyflow_ui_ui_util_open_folder (SteadyflowCoreIDownloadFile* file);
void steadyflow_ui_ui_util_install_clear_handler (GtkEntry* entry);
static Block2Data* block2_data_ref (Block2Data* _data2_);
static void block2_data_unref (void * _userdata_);
static void __lambda6_ (Block2Data* _data2_);
static void ___lambda6__gtk_editable_changed (GtkEditable* _sender, gpointer self);
static void __lambda7_ (Block2Data* _data2_, GtkEntryIconPosition position, GdkEvent* event);
static void ___lambda7__gtk_entry_icon_press (GtkEntry* _sender, GtkEntryIconPosition p0, GdkEvent* p1, gpointer self);


static SteadyflowUIUIUtil* steadyflow_ui_ui_util_construct (GType object_type) {
	SteadyflowUIUIUtil * self = NULL;
	self = (SteadyflowUIUIUtil*) g_object_new (object_type, NULL);
	return self;
}


static SteadyflowUIUIUtil* steadyflow_ui_ui_util_new (void) {
	return steadyflow_ui_ui_util_construct (STEADYFLOW_UI_TYPE_UI_UTIL);
}


void steadyflow_ui_ui_util_open_file (SteadyflowCoreIDownloadFile* file) {
	SteadyflowCoreIDownloadFile* _tmp0_;
	const gchar* _tmp1_;
	const gchar* _tmp2_;
	GFile* _tmp3_ = NULL;
	GFile* gfile;
	GError * _inner_error_ = NULL;
	g_return_if_fail (file != NULL);
	_tmp0_ = file;
	_tmp1_ = steadyflow_core_idownload_file_get_local_name (_tmp0_);
	_tmp2_ = _tmp1_;
	_tmp3_ = g_file_new_for_path (_tmp2_);
	gfile = _tmp3_;
	{
		GdkScreen* _tmp4_ = NULL;
		gchar* _tmp5_ = NULL;
		gchar* _tmp6_;
		_tmp4_ = gdk_screen_get_default ();
		_tmp5_ = g_file_get_uri (gfile);
		_tmp6_ = _tmp5_;
		gtk_show_uri (_tmp4_, _tmp6_, (guint32) GDK_CURRENT_TIME, &_inner_error_);
		_g_free0 (_tmp6_);
		if (_inner_error_ != NULL) {
			goto __catch10_g_error;
		}
	}
	goto __finally10;
	__catch10_g_error:
	{
		GError* e = NULL;
		FILE* _tmp7_;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp7_ = stderr;
		fprintf (_tmp7_, "Could not execute post-download action\n");
		_g_error_free0 (e);
	}
	__finally10:
	if (_inner_error_ != NULL) {
		_g_object_unref0 (gfile);
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return;
	}
	_g_object_unref0 (gfile);
}


void steadyflow_ui_ui_util_open_folder (SteadyflowCoreIDownloadFile* file) {
	SteadyflowCoreIDownloadFile* _tmp0_;
	const gchar* _tmp1_;
	const gchar* _tmp2_;
	GFile* _tmp3_ = NULL;
	GFile* gfile;
	GError * _inner_error_ = NULL;
	g_return_if_fail (file != NULL);
	_tmp0_ = file;
	_tmp1_ = steadyflow_core_idownload_file_get_local_name (_tmp0_);
	_tmp2_ = _tmp1_;
	_tmp3_ = g_file_new_for_path (_tmp2_);
	gfile = _tmp3_;
	{
		GdkScreen* _tmp4_ = NULL;
		GFile* _tmp5_ = NULL;
		GFile* _tmp6_;
		gchar* _tmp7_ = NULL;
		gchar* _tmp8_;
		_tmp4_ = gdk_screen_get_default ();
		_tmp5_ = g_file_get_parent (gfile);
		_tmp6_ = _tmp5_;
		_tmp7_ = g_file_get_uri (_tmp6_);
		_tmp8_ = _tmp7_;
		gtk_show_uri (_tmp4_, _tmp8_, (guint32) GDK_CURRENT_TIME, &_inner_error_);
		_g_free0 (_tmp8_);
		_g_object_unref0 (_tmp6_);
		if (_inner_error_ != NULL) {
			goto __catch11_g_error;
		}
	}
	goto __finally11;
	__catch11_g_error:
	{
		GError* e = NULL;
		FILE* _tmp9_;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp9_ = stderr;
		fprintf (_tmp9_, "Could not execute post-download action\n");
		_g_error_free0 (e);
	}
	__finally11:
	if (_inner_error_ != NULL) {
		_g_object_unref0 (gfile);
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return;
	}
	_g_object_unref0 (gfile);
}


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


static Block2Data* block2_data_ref (Block2Data* _data2_) {
	g_atomic_int_inc (&_data2_->_ref_count_);
	return _data2_;
}


static void block2_data_unref (void * _userdata_) {
	Block2Data* _data2_;
	_data2_ = (Block2Data*) _userdata_;
	if (g_atomic_int_dec_and_test (&_data2_->_ref_count_)) {
		_g_object_unref0 (_data2_->entry);
		g_slice_free (Block2Data, _data2_);
	}
}


static void __lambda6_ (Block2Data* _data2_) {
	GtkEntry* _tmp0_;
	const gchar* _tmp1_;
	const gchar* _tmp2_;
	_tmp0_ = _data2_->entry;
	_tmp1_ = gtk_entry_get_text (_tmp0_);
	_tmp2_ = _tmp1_;
	if (g_strcmp0 (_tmp2_, "") == 0) {
		GtkEntry* _tmp3_;
		_tmp3_ = _data2_->entry;
		g_object_set (_tmp3_, "secondary-icon-name", NULL, NULL);
	} else {
		GtkEntry* _tmp4_;
		GtkEntry* _tmp5_;
		const gchar* _tmp6_ = NULL;
		GtkIconTheme* _tmp7_ = NULL;
		gboolean _tmp8_ = FALSE;
		_tmp4_ = _data2_->entry;
		g_object_set (_tmp4_, "secondary-icon-activatable", TRUE, NULL);
		_tmp5_ = _data2_->entry;
		_tmp6_ = _ ("Clear");
		g_object_set (_tmp5_, "secondary-icon-tooltip-text", _tmp6_, NULL);
		_tmp7_ = gtk_icon_theme_get_default ();
		_tmp8_ = gtk_icon_theme_has_icon (_tmp7_, "edit-clear-symbolic");
		if (_tmp8_) {
			GtkEntry* _tmp9_;
			_tmp9_ = _data2_->entry;
			g_object_set (_tmp9_, "secondary-icon-name", "edit-clear-symbolic", NULL);
		} else {
			GtkEntry* _tmp10_;
			_tmp10_ = _data2_->entry;
			g_object_set (_tmp10_, "secondary-icon-stock", GTK_STOCK_CLEAR, NULL);
		}
	}
}


static void ___lambda6__gtk_editable_changed (GtkEditable* _sender, gpointer self) {
	__lambda6_ (self);
}


static void __lambda7_ (Block2Data* _data2_, GtkEntryIconPosition position, GdkEvent* event) {
	GtkEntryIconPosition _tmp0_;
	g_return_if_fail (event != NULL);
	_tmp0_ = position;
	if (_tmp0_ == GTK_ENTRY_ICON_SECONDARY) {
		GtkEntry* _tmp1_;
		_tmp1_ = _data2_->entry;
		gtk_entry_set_text (_tmp1_, "");
	}
}


static void ___lambda7__gtk_entry_icon_press (GtkEntry* _sender, GtkEntryIconPosition p0, GdkEvent* p1, gpointer self) {
	__lambda7_ (self, p0, p1);
}


void steadyflow_ui_ui_util_install_clear_handler (GtkEntry* entry) {
	Block2Data* _data2_;
	GtkEntry* _tmp0_;
	GtkEntry* _tmp1_;
	GtkEntry* _tmp2_;
	GtkEntry* _tmp3_;
	g_return_if_fail (entry != NULL);
	_data2_ = g_slice_new0 (Block2Data);
	_data2_->_ref_count_ = 1;
	_tmp0_ = entry;
	_tmp1_ = _g_object_ref0 (_tmp0_);
	_data2_->entry = _tmp1_;
	_tmp2_ = _data2_->entry;
	g_signal_connect_data ((GtkEditable*) _tmp2_, "changed", (GCallback) ___lambda6__gtk_editable_changed, block2_data_ref (_data2_), (GClosureNotify) block2_data_unref, 0);
	_tmp3_ = _data2_->entry;
	g_signal_connect_data (_tmp3_, "icon-press", (GCallback) ___lambda7__gtk_entry_icon_press, block2_data_ref (_data2_), (GClosureNotify) block2_data_unref, 0);
	block2_data_unref (_data2_);
	_data2_ = NULL;
}


static void steadyflow_ui_ui_util_class_init (SteadyflowUIUIUtilClass * klass) {
	steadyflow_ui_ui_util_parent_class = g_type_class_peek_parent (klass);
}


static void steadyflow_ui_ui_util_instance_init (SteadyflowUIUIUtil * self) {
}


GType steadyflow_ui_ui_util_get_type (void) {
	static volatile gsize steadyflow_ui_ui_util_type_id__volatile = 0;
	if (g_once_init_enter (&steadyflow_ui_ui_util_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (SteadyflowUIUIUtilClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) steadyflow_ui_ui_util_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (SteadyflowUIUIUtil), 0, (GInstanceInitFunc) steadyflow_ui_ui_util_instance_init, NULL };
		GType steadyflow_ui_ui_util_type_id;
		steadyflow_ui_ui_util_type_id = g_type_register_static (G_TYPE_OBJECT, "SteadyflowUIUIUtil", &g_define_type_info, 0);
		g_once_init_leave (&steadyflow_ui_ui_util_type_id__volatile, steadyflow_ui_ui_util_type_id);
	}
	return steadyflow_ui_ui_util_type_id__volatile;
}


