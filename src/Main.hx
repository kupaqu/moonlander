import screens.*;

class Main extends hxd.App {

    public var screen: Screen;

    override function init() {
        @:privateAccess haxe.MainLoop.add(() -> {});
        hxd.Res.initEmbed();
        screen = new Game(this);
        setScene(screen);
    }

    override function update(dt: Float) {
        screen.update(dt);
    }

    static function main() {
        new Main();
    }
}