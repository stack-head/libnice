	
GSTPYDEFS=`pkg-config --variable=defsdir gst-python-0.10`
PYOBJECT_CFLAGS=`pkg-config --cflags pygobject-2.0`

AM_CFLAGS = \
	-I.						\
	-I$(top_srcdir)/gst-libs/			\
	-DG_LOG_DOMAIN=\"libnice\" \
	$(ERROR_CFLAGS) \
	$(GLIB_CFLAGS) \
	$(GUPNP_CFLAGS) \
	$(PYTHON_INCLUDES)				\
	$(PYOBJECT_CFLAGS) \
	-I $(top_srcdir) \
	-I $(top_srcdir)/random \
	-I $(top_srcdir)/socket \
	-I $(top_srcdir)/stun	\
	-I $(top_srcdir)/agent

BUILT_SOURCES =						\
	pylibnice.c \
    agent-enumtypes.c

pylibnicedir = $(pyexecdir)
pylibnice_LTLIBRARIES = libnice.la

libnice_la_SOURCES =					\
	pylibnicemodule.c

nodist_libnice_la_SOURCES = pylibnice.c \
    agent-enumtypes.c \
    agent-enumtypes.h

libnice_la_LIBADD =					\
	$(PYLIBNICE_LIBS)				\
	$(top_builddir)/nice/libnice.la

libnice_la_LDFLAGS = -module -avoid-version

agent-enumtypes.c: ./../agent/agent.h ./../agent/candidate.h
	$(AM_V_GEN)glib-mkenums \
	--fhead "#include \"agent-enumtypes.h\"\n#include \"./../agent/agent.h\"\n#include \"./../agent/candidate.h\"\n" \
	--fprod "\n/* enumerations from \"@filename@\" */" \
	--vhead "GType\n@enum_name@_get_type (void)\n{\n  static volatile gsize g_define_type_id__volatile = 0;\n  if (g_once_init_enter (&g_define_type_id__volatile)) {\n    static const G@Type@Value values[] = {"     \
	--vprod "      { @VALUENAME@, \"@VALUENAME@\", \"@valuenick@\" }," \
	--vtail "      { 0, NULL, NULL }\n    };\n    GType g_define_type_id = g_@type@_register_static (\"@EnumName@\", values);\n    g_once_init_leave (&g_define_type_id__volatile, g_define_type_id);\n  }\n  return g_define_type_id__volatile;\n}\n" \
	$^ > $@


agent-enumtypes.h: ./../agent/agent.h ./../agent/candidate.h
	$(AM_V_GEN)glib-mkenums \
	--fhead "#ifndef __AGENT_ENUM_TYPES_H__\n#define __AGENT_ENUM_TYPES_H__\n\n#include <glib-object.h>\n\nG_BEGIN_DECLS\n" \
	--fprod "\n/* enumerations from \"@filename@\" */\n" \
	--vhead "GType @enum_name@_get_type (void);\n#define NICE_TYPE_@ENUMSHORT@ (@enum_name@_get_type())\n" \
	--ftail "G_END_DECLS\n\n#endif /* __AGENT_ENUM_TYPES_H__ */" \
	$^ > $@	

pylibnice.c: pylibnice.override pylibnice.defs agent-enumtypes.h agent-enumtypes.c
	$(PYCODEGEN)						\
		--prefix libnice				\
		--register $(GSTPYDEFS)/gst-types.defs		\
		--override $(srcdir)/pylibnice.override	\
		$(srcdir)/pylibnice.defs > $@ 

EXTRA_DIST =			\
	pylibnice.override	\
	pylibnice.defs		\
	pylibnice-filter.defs  \
	rebuild-defs.sh

CLEANFILES = $(BUILT_SOURCES)
