package entities;

import screens.*;

class Lander extends h2d.Bitmap {
    var g: Float = 20;
    public var vy = 0.;
    public var vx = 0.;
    var poly: h2d.col.Polygon;
    var rotationAngle = 0.025;
    public var acceptableAngle = 0.3;
    public var fuel = 1000.;

    var p: h2d.Graphics;

    var engineAcceleration: Float = 50;

    public function new(parent: Screen) {
        super(hxd.Res.loader.load('ufo.png').toTile(), parent);
        scale(0.75);
        tile.dx -= tile.width/2;
        tile.dy -= tile.height/2;
        x = hxd.Window.getInstance().width / 2;
        y = -250;

        var b = getBounds();
        poly = new h2d.col.Polygon([
            new h2d.col.Point(b.x - x, b.y - y),
            new h2d.col.Point(b.xMax - x, b.y - y),
            new h2d.col.Point(b.xMax - x, b.yMax - y),
            new h2d.col.Point(b.x - x, b.yMax - y)
        ]);
        p = new h2d.Graphics(parent);

        vx = 10.;
    }

    public function reset() {
        for (point in poly.points) point.rotate(-rotation);
        
        x = hxd.Window.getInstance().width / 2;
        y = -250;
        rotation = 0;

        vx = 10.;
        vy = 0.;
    }

    public function getPoly() {
        var polyWithOffset = new Array<h2d.col.Point>();
        for (point in poly.points) {
            polyWithOffset.push(new h2d.col.Point(point.x + x, point.y + y));
        }
        return polyWithOffset;
    }

    public function update(dt: Float) {
        y += vy*dt;
        x += vx*dt;

        if (hxd.Key.isDown(hxd.Key.UP) && fuel > 0.) {
            vy -= Math.sin(rotation+Math.PI/2)*engineAcceleration*dt;
            vx -= Math.cos(rotation+Math.PI/2)*engineAcceleration*dt;
            fuel -= 0.2;
        }
        if (hxd.Key.isDown(hxd.Key.RIGHT) && rotation * 180/Math.PI <= 90) {
            rotate(rotationAngle);
            for (point in poly.points) point.rotate(rotationAngle);
        }
        if (hxd.Key.isDown(hxd.Key.LEFT) && rotation * 180/Math.PI >= -90) {
            rotate(-rotationAngle);
            for (point in poly.points) point.rotate(-rotationAngle);
        }

        vy += g*dt;
        
        p.clear();
        p.beginFill(0xD1CBCB);
        for (point in getPoly()) {
            p.drawCircle(point.x, point.y, 1);
        }
    }
}