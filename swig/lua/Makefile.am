#
# This file is part of project GEOS (http://trac.osgeo.org/geos/) 
#
EXTRA_DIST = \
	lua.i

MAINTAINERCLEANFILES = geos_wrap.cxx

if ENABLE_LUA

SUBDIRS = \
	tests

BUILT_SOURCES = geos_wrap.cxx

# Don't know why there needs to be dirdir but it makes automake happy
luaextensiondirdir = /usr/lib/lua/5.1/

# Setup includes
INCLUDES = $(LUA_INCLUDE)

luaextensiondir_LTLIBRARIES = geos.la
geos_la_SOURCES = geos_wrap.cxx
geos_la_LIBADD =  $(top_builddir)/capi/libgeos_c.la $(LUA_LIB)
geos_la_CPPFLAGS = -I$(top_builddir)/capi -fpermissive
geos_la_LDFLAGS = -no-undefined  -module -avoid-version

if ENABLE_SWIG

geos_wrap.cxx: ../geos.i lua.i
	$(SWIG) -c++ -lua -o $@ $<

else # !ENABLE_SWIG

geos_wrap.cxx: ../geos.i lua.i
	@echo "SWIG is disabled, can't build geos_wrap.cxx"
	false

endif # ENABLE_SWIG

endif # ENABLE_LUA
