#
# This file is part of project GEOS (http://trac.osgeo.org/geos/) 
#

DIST_SUBDIRS = python ruby lua
SUBDIRS =

if ENABLE_PYTHON
 SUBDIRS += python
endif

if ENABLE_RUBY
 SUBDIRS += ruby
endif

if ENABLE_LUA
 SUBDIRS += lua
endif

EXTRA_DIST = \
	geos.i \
	typemap.i
