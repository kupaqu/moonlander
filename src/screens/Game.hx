package screens;

import h2d.Scene;
import entities.*;

class Game extends Screen {
    var lander: Lander;
    var ground: Ground;
    var gui: Gui;
    public var mode = 0;

    public function new(app: Main) {
        super(app);
        defaultSmooth = true;

        lander = new Lander(this);
        ground = new Ground(this, lander);
        gui = new Gui(app, lander);

        addCamera(new h2d.Camera(), 0);
        interactiveCamera = cameras[0];
        removeCamera(cameras[1]);

        camera.follow = lander;
        camera.anchorX = 0.5;
        camera.anchorY = 0.5;
        camera.scaleX = 0.75;
        camera.scaleY = 0.75;

        // gui = new Gui(app);
        // var text = new h2d.Text(hxd.res.DefaultFont.get(), gui);
        // text.text = 'Hello World!';
    }

    override function render(engine: h3d.Engine) {
        super.render(engine);
        gui.render(engine);
    }

    override public function update(dt: Float) {
        lander.update(dt);
        ground.update(dt);
        gui.update(dt);
        // if (mode == 0) {
        //     lander.update(dt);
        //     ground.update(dt);
        // }
        // if (mode == 1) {
        //     var text = new h2d.Text(hxd.res.DefaultFont.get(), this);
        //     text.scale(2);
        //     text.text = 'YOU WIN! ${lander.rotation}';
        //     text.x = lander.x;
        //     text.y = lander.y;
        //     mode = 3;
        // }
        // if (mode == 2) {
        //     var text = new h2d.Text(hxd.res.DefaultFont.get(), this);
        //     text.scale(2);
        //     text.text = 'YOU LOSE! ${lander.rotation}';
        //     text.x = lander.x;
        //     text.y = lander.y;
        //     mode = 3;
        // }
    }
}