package.cpath = '../.libs/?.so'
local geos = require 'geos'

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

function do_all()
    local geoms = {}
    table.insert(geoms, create_point(150,350))
    table.insert(geoms, create_ushaped_linestring(60,60,100))
    table.insert(geoms, create_square_linearring(0,100,100))
    table.insert(geoms, create_square_polygon(0,200,300))

    print "--------HERE ARE THE BASE GEOMS ----------"
    wkt_print_geoms(geoms)

end

print("GEOS", geos.version(), "ported from JTS", geos.GEOS_JTS_PORT)
do_all()
