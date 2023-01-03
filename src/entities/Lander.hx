package entities;

import screens.*;

class Lander extends h2d.Bitmap {
    var g: Float = 9.8;
    var vy: Float;
    var vx: Float;

    var poly: h2d.col.Polygon;

    var p: h2d.Graphics;

    var engineAcceleration: Float = 9.8*20;

    public function new(parent: Screen) {
        super(hxd.Res.loader.load('ufo.png').toTile(), parent);
        tile.dx -= tile.width/2;
        tile.dy -= tile.height/2;
        x = hxd.Window.getInstance().width / 2;
        y = hxd.Window.getInstance().height / 2;

        var b = getBounds();
        poly = new h2d.col.Polygon([
            new h2d.col.Point(b.x - x, b.y - y),
            new h2d.col.Point(b.xMax - x, b.y - y),
            new h2d.col.Point(b.xMax - x, b.yMax - y),
            new h2d.col.Point(b.x - x, b.yMax - y)
        ]);
        p = new h2d.Graphics(parent);
    }

    public function update(dt: Float) {
        y += vy*dt;
        x += vx*dt;

        if (hxd.Key.isPressed(hxd.Key.UP)) {
            vy -= Math.sin(rotation+Math.PI/2)*engineAcceleration*dt;
            vx -= Math.cos(rotation+Math.PI/2)*engineAcceleration*dt;
        }
        if (hxd.Key.isPressed(hxd.Key.RIGHT)) {
            rotate(0.01);
            for (point in poly.points) point.rotate(0.01);
        }
        if (hxd.Key.isPressed(hxd.Key.LEFT)) {
            rotate(-0.01);
            for (point in poly.points) point.rotate(-0.01);
        }
        vy += g*dt;
        
        p.clear();
        p.beginFill(0xD1CBCB);
        for (point in poly.points) {
            p.drawCircle(point.x + x, point.y + y, 2);
        }
    }
}