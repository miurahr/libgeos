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
    }
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


