package screens;

import h2d.Scene;
import entities.*;

class Game extends Screen {
    var lander: Lander;
    var ground: Ground;
    var gui: Gui;
    var hint: h2d.Text;
    public var mode = -1;

    public function new(app: Main) {
        super(app);
        defaultSmooth = true;

        hxd.Res.song.play(true, 0.8);

        lander = new Lander(this);
        ground = new Ground(this, lander);
        gui = new Gui(app, lander);

        hint = new h2d.Text(hxd.res.DefaultFont.get(), gui);
        hint.textAlign = Center;
        hint.x = hxd.Window.getInstance().width/2;
        hint.scale(2);
        hint.y = hint.textHeight*2;
        hint.text = 'PRESS SPACE TO START.\nLAND ON GREEN SEGMENTS.';

        addCamera(new h2d.Camera(), 0);
        interactiveCamera = cameras[0];
        removeCamera(cameras[1]);

        camera.follow = lander;
        camera.anchorX = 0.5;
        camera.anchorY = 0.5;
        camera.scaleX = 0.75;
        camera.scaleY = 0.75;
    }

    override function render(engine: h3d.Engine) {
        super.render(engine);
        gui.render(engine);
    }

    public function reset() {
        lander.reset();
        mode = 0;
    }

    override public function update(dt: Float) {
        gui.update(dt);

        if (lander.fuel < 200) {
            gui.displayWarning();
        }
        
        if (mode == -1) {
            ground.update(dt);
            if (hxd.Key.isDown(hxd.Key.SPACE)) {
                hint.visible = false;
                mode = 0;
            }
        } else if (mode == 0) {
            lander.update(dt);
            ground.update(dt);
        } else if (mode == 1) {
            gui.score += 100;
            gui.displayResult(true);
            reset();
            if (lander.fuel <= 0) {
                lander.fuel = 1000;
                gui.score = 0;
            }
            mode = 0;
        } else if (mode == 2) {
            gui.displayResult(false);
            reset();
            if (lander.fuel <= 0) {
                lander.fuel = 1000;
                gui.score = 0;
            }
            mode = 0;
        }
    }
}