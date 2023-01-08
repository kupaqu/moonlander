package screens;

import entities.*;

class Gui extends Screen {
    var lander: Lander;
    var score: Int;

    var fuel: h2d.Text;
    var vx: h2d.Text;
    var vy: h2d.Text;
    var angle: h2d.Text;

    public function new(app: Main, lander: Lander) {
        super(app);
        this.lander = lander;
        fuel = new h2d.Text(hxd.res.DefaultFont.get(), this);
        vx = new h2d.Text(hxd.res.DefaultFont.get(), this);
        vy = new h2d.Text(hxd.res.DefaultFont.get(), this);
        angle = new h2d.Text(hxd.res.DefaultFont.get(), this);

        fuel.y = fuel.textHeight*2;
        vx.y = fuel.y+fuel.textHeight*2;
        vy.y = vx.y+vx.textHeight*2;
        angle.y = vy.y+vy.textHeight*2;

        fuel.x = fuel.y;
        vx.x = fuel.x;
        vy.x = fuel.x;
        angle.x = fuel.x;

        fuel.scale(2);
        vx.scale(2);
        vy.scale(2);
        angle.scale(2);
    }
    
    override public function update(dt: Float) {
        fuel.text = 'FUEL: ${Math.round(lander.fuel)}';
        vx.text = 'HORIZONTAL SPEED: ${Math.abs(Math.round(lander.vx))}';
        vy.text = 'VERTICAL SPEED: ${Math.abs(Math.round(lander.vy))}';
        angle.text = 'ANGLE: ${Math.abs(Math.round(lander.rotation * 180/Math.PI))}';
    }

    public function displayResult(isWin: Bool) {

    }

    public function displayWarning() {
        
    }
    
}