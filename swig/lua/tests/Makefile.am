#
# This file is part of project GEOS (http://trac.osgeo.org/geos/) 
#

LUA_CPATH = '.libs/?.so'
LUA_TESTS = \
	print_geos.lua \
	example.lua

EXTRA_DIST = $(LUA_TESTS)

test:
	$(LUA) example.lua
	$(LUA) print_geos.lua
