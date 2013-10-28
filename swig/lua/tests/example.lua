package.cpath = '../.libs/?.so'
local geos = require 'geos'
-- local math = require 'math'
-- local geosutils = require 'geosutils'

function wkt_print_geoms(geoms)
    local wkt = geos.WktWriter()
    for i,v in pairs(geoms) do
        tmp = wkt:write(v)
        print(i, tmp)
    end
end

function create_point(x,y)
    local cl = geos.CoordinateSequence(1,2)
    cl:setX(0,x)
    cl:setY(0,y)

    return geos.createPoint(cl)
end

function create_ushaped_linestring(xoffset, yoffset, side)
    local cl = geos.CoordinateSequence(4,2)
    cl:setX(0,xoffset)
    cl:setY(0,yoffset)
    cl:setX(1,xoffset)
    cl:setY(1,yoffset+side)
    cl:setX(2,xoffset+side)
    cl:setY(2,yoffset+side)
    cl:setX(3,xoffset+side)
    cl:setY(3,yoffset)

    return geos.createLineString(cl)
end

function create_square_linearring(xoffset, yoffset, side)
    local cl = geos.CoordinateSequence(5,2)
    cl:setX(0,xoffset)
    cl:setY(0,yoffset)
    cl:setX(1,xoffset)
    cl:setY(1,yoffset+side)
    cl:setX(2,xoffset+side)
    cl:setY(2,yoffset+side)
    cl:setX(3,xoffset+side)
    cl:setY(3,yoffset)
    cl:setX(4,xoffset)
    cl:setY(4,yoffset)

    return geos.createLinearRing(cl)
end

function create_square_polygon(xoffset,yoffset,side)
    local inner = {}
    local outer = create_square_linearring(xoffset,yoffset,side)
    inner.insert = create_square_linearring(xoffset+(side/3.),yoffset+(side/3.),(side/3.))

    return geos.createPolygon(outer,inner)
end

function getn (t)
  local max = 0
  for i, _ in pairs(t) do
    if type(i) == "number" and i>max then max=i end
  end
  return max
end

function create_simple_collection(geoms)
    -- FIXME: fail to error something wrong...
    local collect = geos.createCollection(geos.GEOS_GEOMETRYCOLLECTION, geoms)
    return collect
end

function create_circle(centerX,centerY,radius)
    local center = geos.Coordinate(centerX, centerY)
    local circle = geosutils.createCircle(center, radius*2, radius*2)
    return circle
end

function create_ellipse(centerX,centerY,width,height)
    local center = geos.Coordinate(centerX, centerY)
    local ellipse = geosutils.createCircle(center, width, height)
    return ellipse
end

function create_rectangle(llX,llY,width,height)
    local base= geos.Coordinate(llX, llY)
    local rectangle = geosutils.createRectangle(base, width, height, 4)
    return rectangle
end

function create_arc(llX,llY,width,height,startang,endang)
    local base = geos.Coordinate(llX, llY)
    local arc = geosutils.createArc(base, width, height, startang, endang)
    return arc
end

function do_emptyobject_tests()
    local geoms = {}
    table.insert(geoms, geos.createEmptyPoint())
    table.insert(geoms, geos.createEmptyLineString())
    table.insert(geoms, geos.createEmptyPolygon())
    table.insert(geoms, geos.createEmptyCollection(geos.GEOS_MULTIPOINT))

    wkt_print_geoms(geoms)
end

function do_all()
    local geoms = {}
    table.insert(geoms, create_point(150,350))
    table.insert(geoms, create_ushaped_linestring(60,60,100))
    table.insert(geoms, create_square_linearring(0,100,100))
    table.insert(geoms, create_square_polygon(0,200,300))
    --table.insert(geoms, create_simple_collection(geoms))

    -- Shape Factory helper methods
    -- table.insert(geoms, create_circle(0, 0, 10))
    -- table.insert(geoms, create_ellipse(0, 0, 8, 12))
    -- table.insert(geoms, create_rectangle(-5, -5, 10, 10))
    -- table.insert(geoms, create_rectangle(-5, -5, 10, 20))

    -- The upper-right quarter of a vertical ellipse
    -- table.insert(geoms, create_arc(0, 0, 10, 20, 0, math.pi/2))

    print "--------HERE ARE THE BASE GEOMS ----------"
    wkt_print_geoms(geoms)

end

print("GEOS", geos.version(), "ported from JTS", geos.GEOS_JTS_PORT)
do_emptyobject_tests()
do_all()
