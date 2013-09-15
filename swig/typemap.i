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
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(result), $descriptor(GeosPoint*), 0 | $owner);
        break;
	case GEOS_LINESTRING:
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(result), $descriptor(GeosLineString*), 0 | $owner);
        break;
	case GEOS_LINEARRING:
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(result), $descriptor(GeosLinearRing*), 0 | $owner);
        break;
	case GEOS_POLYGON:
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(result), $descriptor(GeosPolygon*), 0 | $owner);
        break;
	case GEOS_MULTIPOINT:
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(result), $descriptor(GeosMultiPoint*), 0 | $owner);
        break;
	case GEOS_MULTILINESTRING:
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(result), $descriptor(GeosMultiLineString*), 0 | $owner);
        break;
	case GEOS_MULTIPOLYGON:
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(result), $descriptor(GeosMultiPolygon*), 0 | $owner);
        break;
	case GEOS_GEOMETRYCOLLECTION:
        $result = SWIG_NewPointerObj(SWIG_as_voidptr(result), $descriptor(GeosGeometryCollection*), 0 | $owner);
        break;
    }
}

// === Input/Output ===

/* This typemap allows the scripting language to pass in buffers
   to the geometry write methods. */
%typemap(in) (const unsigned char* wkb, size_t size) (int alloc = 0)
{
    /* %typemap(in) (const unsigned char* wkb, size_t size) (int alloc = 0) */
    if (SWIG_AsCharPtrAndSize($input, (char**)&$1, &$2, &alloc) != SWIG_OK)
        SWIG_exception(SWIG_RuntimeError, "Expecting a string");
    /* Don't want to include last null character! */
    $2--;
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
    $result = SWIG_FromCharPtrAndSize((const char*)result, *$1);
}

/* Free the c-string returned  by the function. */
%typemap(freearg) size_t *size
{
    /* %typemap(freearg) size_t *size */
    std::free(result);
}


