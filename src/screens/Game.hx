package screens;

import h2d.Camera;
import entities.*;

class Game extends Screen {
    var lander: Lander;
    var ground: Ground;
    var cam: h2d.Camera;

    public function new(app: Main) {
        super(app);
        lander = new Lander(this);
        ground = new Ground(this, lander);
    }

    override public function update(dt: Float) {
        lander.update(dt);
        ground.update(dt);
    }
}