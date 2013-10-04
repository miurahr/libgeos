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

/* FIXME */
%newobject createCollection;
%inline %{
GeosGeometry *createCollection(int type, GEOSGeom *geoms, size_t ngeoms)
{
    GEOSGeom geom = GEOSGeom_createCollection(type, geoms, ngeoms);

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}
%}

%newobject createEmptyPoint;
%newobject createEmptyLineString;
%newobject createEmptyPolygon;
%newobject createEmptyCollection;
%newobject createEmptyPoint_r;
%newobject createEmptyLineString_r;
%newobject createEmptyPolygon_r;
%newobject createEmptyCollection_r;

%inline %{
GeosGeometry *createEmptyPoint()
{
    GEOSGeom geom = GEOSGeom_createEmptyPoint();

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}

GeosGeometry *createEmptyLineString()
{
    GEOSGeom geom = GEOSGeom_createEmptyLineString();

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}

GeosGeometry *createEmptyPolygon()
{
    GEOSGeom geom = GEOSGeom_createEmptyPolygon();

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}

GeosGeometry *createEmptyCollection(int type)
{
    GEOSGeom geom = GEOSGeom_createEmptyCollection(type);

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}

GeosGeometry *createEmptyPoint_r(GEOSContextHandle_t handle)
{
    GEOSGeom geom = GEOSGeom_createEmptyPoint_r(handle);

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}

GeosGeometry *createEmptyLineString_r(GEOSContextHandle_t handle)
{
    GEOSGeom geom = GEOSGeom_createEmptyLineString_r(handle);

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}

GeosGeometry *createEmptyPolygon_r(GEOSContextHandle_t handle)
{
    GEOSGeom geom = GEOSGeom_createEmptyPolygon_r(handle);

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}

GeosGeometry *createEmptyCollection_r(GEOSContextHandle_t handle,int type)
{
    GEOSGeom geom = GEOSGeom_createEmptyCollection_r(handle, type);

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}

%}
