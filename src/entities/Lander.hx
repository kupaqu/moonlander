package entities;

import screens.*;

class Lander extends h2d.Bitmap {
    var g: Float = 9.8;
    var vy: Float;
    var vx: Float;

    var engineAcceleration: Float = 9.8*20;

    public function new(parent: Screen) {
        super(hxd.Res.loader.load('ufo.png').toTile(), parent);
        tile.dx -= tile.width/2;
        tile.dy -= tile.height/2;
    }

    public function update(dt: Float) {
        y += vy*dt;
        x += vx*dt;

        if (hxd.Key.isPressed(hxd.Key.UP)) {
            vy -= Math.sin(rotation+Math.PI/2)*engineAcceleration*dt;
            vx -= Math.cos(rotation+Math.PI/2)*engineAcceleration*dt;
        }
        if (hxd.Key.isPressed(hxd.Key.RIGHT)) rotate(0.01);
        if (hxd.Key.isPressed(hxd.Key.LEFT)) rotate(-0.01);

        vy += g*dt;
    }
}