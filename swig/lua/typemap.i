/* =========================================================================
 * Copyright 2005-2007 Charlie Savage, cfis@interserv.com
 * Copyright 2013 Hiroshi Miura, miurahr@linux.com
 *
 * Interface for a SWIG generated geos module.
 *
 * This is free software; you can redistribute and/or modify it under
 * the terms of the GNU Lesser General Public Licence as published
 * by the Free Software Foundation. 
 * See the COPYING file for more information.
 *
 * ========================================================================= */

/* Convert a Lua table of GeosGeometry to a C array of GeosGeom */
/* FIXME */
%typemap(in, numinputs=1) (GEOSGeom *geoms, size_t ngeoms)
{
    if (!lua_toboolean(L,-1))
    {
        $1 = NULL;
        $2 = 0;
    }
    else
    {
        luaL_checktype(L, -1, LUA_TTABLE);
        $2 = lua_objlen(L, -1);
        $1 = (GEOSGeom*) malloc($2*sizeof(GEOSGeom*));
        for (size_t i = 0; i < $2; i++)
        {
            lua_rawgeti(L, -1, i+1);
            GEOSGeom geom = NULL;
            int convertResult = SWIG_ConvertPtr(L, -1, (void**)&geom, $descriptor(GEOSGeom), SWIG_POINTER_DISOWN);
            if (!SWIG_IsOK(convertResult)) {
                lua_pushstring(L, "something has been wrong");
                SWIG_fail;
            }
            $1[i] = geom;
        }
    }
}

%typemap(freearg) (GEOSGeom *geoms, size_t ngeoms)
{
  if ($1) {
    free((void*) $1);
  }
}

/* Convert a Lua table of GeosLinearRings to a C array. */
%typemap(in,numinputs=1) (GeosLinearRing **holes, size_t nholes)
{
    if (!lua_toboolean(L,-1))
    {
        $1 = NULL;
        $2 = 0;
    }
    else
    {
        /* Make sure the input can be treated as an table. */
        luaL_checktype(L, -1, LUA_TTABLE);
        $2 = lua_objlen(L, -1);
        /* Allocate space for the C array. */
        $1 = (GeosLinearRing**) malloc($2*sizeof(GeosLinearRing*));
        for(size_t i = 0; i < $2; i++)
        {
            lua_rawgeti(L, -1, i+1); // key=1..len
            /* Get the underlying pointer and give up ownership of it. */
            GeosLinearRing *ring = NULL;
            int convertResult = SWIG_ConvertPtr(L, -1, (void**)&ring, $descriptor(GeosLinearRing*), SWIG_POINTER_DISOWN);
            if (!SWIG_IsOK(convertResult)) {
                lua_pushstring(L,"Something has been wrong");
                SWIG_fail;
            }
            /* Put the pointer in the array */
            $1[i] = ring;
        }    
    }
}

%typemap(freearg)  (GeosLinearRing **holes, size_t nholes)
{
  if ($1) {
    free((void*) $1);
  }
}

%typemap(out) GeosGeometry*
{

    /* %typemap(out) GeosGeometry */

    if ($1 == NULL)
        SWIG_exception(SWIG_RuntimeError, message);

    GeosGeometry *geom = $1;
    GEOSGeomTypes geomId = (GEOSGeomTypes)GEOSGeomTypeId((GEOSGeom) geom);

    switch (geomId)
    {
    case GEOS_POINT:
        SWIG_NewPointerObj(L, (void *)(result), $descriptor(GeosPoint*), $owner);
        break;
    case GEOS_LINESTRING:
        SWIG_NewPointerObj(L, (void *)(result), $descriptor(GeosLineString*), $owner);
        break;
    case GEOS_LINEARRING:
        SWIG_NewPointerObj(L, (void *)(result), $descriptor(GeosLinearRing*), $owner);
        break;
    case GEOS_POLYGON:
        SWIG_NewPointerObj(L, (void *)(result), $descriptor(GeosPolygon*), $owner);
        break;
    case GEOS_MULTIPOINT:
        SWIG_NewPointerObj(L, (void *)(result), $descriptor(GeosMultiPoint*), $owner);
        break;
    case GEOS_MULTILINESTRING:
        SWIG_NewPointerObj(L, (void *)(result), $descriptor(GeosMultiLineString*), $owner);
        break;
    case GEOS_MULTIPOLYGON:
        SWIG_NewPointerObj(L, (void *)(result), $descriptor(GeosMultiPolygon*), $owner);
        break;
    case GEOS_GEOMETRYCOLLECTION:
        SWIG_NewPointerObj(L, (void *)(result), $descriptor(GeosGeometryCollection*), $owner);
        break;
    default:
        lua_pushstring(L,"something bad happened");
        SWIG_fail;
    }
    SWIG_arg++;
}

// === Input/Output ===

/* This typemap allows the scripting language to pass in buffers
   to the geometry write methods. */
%typemap(in) (const unsigned char* wkb, size_t size) (int alloc = 0)
{
    /* %typemap(in) (const unsigned char* wkb, size_t size) (int alloc = 0) */
    $1 = luaL_checkstring(L, 1);
    $2 = luaL_checknumber(L, 2);
    if (!$1 || $2 == 0)
        SWIG_exception(SWIG_RuntimeError, "Expecting a string");
}

/* These three type maps are for geomToWKB and geomToHEX.  We need
to ignore the size input argument, then create a new string in the
scripting language of the correct size, and then free the 
provided string. */

/* set the size parameter to a temporary variable. */
%typemap(in, numinputs=0) size_t *size (size_t temp = 0)
{
    /* %typemap(in, numinputs=0) size_t *size (size_t temp = 0) */
    $1 = &temp;
}

/* Disable SWIG's normally generated code so we can replace it
   with the argout typemap below. */
%typemap(out) unsigned char*
{
    /* %typemap(out) unsigned char* */
}

/* Create a new target string of the correct size. */
%typemap(argout) size_t *size
{
    /* %typemap(argout) size_t *size */
    lua_pushlstring(L, result, *$1);
}

/* Free the c-string returned  by the function. */
%typemap(freearg) size_t *size
{
    /* %typemap(freearg) size_t *size */
    free(result);
}

/* Setup a default typemap for buffer. */
%typemap(default) int quadsegs
{
    $1 = DEFAULT_QUADRANT_SEGMENTS;
}
