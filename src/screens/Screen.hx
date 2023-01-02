package screens;

import h2d.Scene;

class Screen extends h2d.Scene {

    var app: Main;

    public function new(app: Main) {
        super();
        this.app = app;
    }

    public function update(df: Float) {}

    public function setScreen(newScreen: Screen) {
        app.screen = newScreen;
        app.setScene(newScreen);
    }
}