package screens;

import entities.*;

class Game extends Screen {
    var lander: Lander;
    var ground: Ground;

    public function new(app: Main) {
        super(app);
        lander = new Lander(this);
        ground = new Ground(this);
    }

    override public function update(dt: Float) {
        lander.update(dt);
        ground.update(dt);
    }
}