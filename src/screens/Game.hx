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

        addCamera(new Camera(), 0);
        interactiveCamera = cameras[0];
        removeCamera(cameras[1]);

        camera.follow = lander;
        camera.anchorX = 0.5;
        camera.anchorY = 0.5;
        // camera.scale(0.5, 0.5);
        camera.scaleX = 0.5;
        camera.scaleY = 0.5;
        // camera.scaleX = 0.5;
        // camera.scaleY = 0.5;
    }

    override public function update(dt: Float) {
        lander.update(dt);
        ground.update(dt);
    }
}