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

%newobject createEmptyPoint;
%inline %{
GeosGeometry *createEmptyPoint()
{
    GEOSGeom geom = GEOSGeom_createEmptyPoint();

    if(geom == NULL)
        throw std::runtime_error(message);

    return (GeosGeometry*) geom;
}
%}
