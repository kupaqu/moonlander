package screens;

import entities.*;

class Gui extends Screen {
    var lander: Lander;
    public var score = 0;

    var fuel: h2d.Text;
    var vx: h2d.Text;
    var vy: h2d.Text;
    var angle: h2d.Text;
    var scoreText: h2d.Text;

    var result: h2d.Text;
    var warn: h2d.Text;

    var timer: Float;

    public function new(app: Main, lander: Lander) {
        super(app);
        this.lander = lander;
        fuel = new h2d.Text(hxd.res.DefaultFont.get(), this);
        vx = new h2d.Text(hxd.res.DefaultFont.get(), this);
        vy = new h2d.Text(hxd.res.DefaultFont.get(), this);
        angle = new h2d.Text(hxd.res.DefaultFont.get(), this);
        scoreText = new h2d.Text(hxd.res.DefaultFont.get(), this);
        
        fuel.y = fuel.textHeight*2;
        vx.y = fuel.y+fuel.textHeight*2;
        vy.y = vx.y+vx.textHeight*2;
        angle.y = vy.y+vy.textHeight*2;
        scoreText.y = angle.y+angle.textHeight*2;
        
        fuel.x = fuel.y;
        vx.x = fuel.x;
        vy.x = fuel.x;
        angle.x = fuel.x;
        scoreText.x = fuel.x;
        
        fuel.scale(2);
        vx.scale(2);
        vy.scale(2);
        angle.scale(2);
        scoreText.scale(2);

        result = new h2d.Text(hxd.res.DefaultFont.get(), this);
        result.textAlign = Center;
        result.x = hxd.Window.getInstance().width/2;
        result.y = fuel.y;
        result.scale(2);
        result.visible = false;

        warn = new h2d.Text(hxd.res.DefaultFont.get(), this);
        warn.textAlign = Center;
        warn.x = hxd.Window.getInstance().width/2;
        warn.y = hxd.Window.getInstance().height - fuel.y*2;
        warn.scale(2);
        warn.visible = false;
    }
    
    override public function update(dt: Float) {
        fuel.text = 'FUEL: ${Math.round(lander.fuel)}';
        vx.text = 'HORIZONTAL SPEED: ${Math.abs(Math.round(lander.vx))}';
        vy.text = 'VERTICAL SPEED: ${Math.abs(Math.round(lander.vy))}';
        angle.text = 'ANGLE: ${Math.abs(Math.round(lander.rotation * 180/Math.PI))}';
        scoreText.text = 'SCORE: ${score}';
    }

    public function displayResult(isWin: Bool) {
        if (isWin) result.text = 'CONGRATULATION.\nSUCCESSFUL LANDING.\n100 POINTS.';
        else result.text = 'MODULE DESTROYED.';
        result.visible = true;
    }

    public function displayWarning() {
        warn.text = 'LOW ON FUEL.';
        warn.visible = true;
    }
    
}