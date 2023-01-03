package entities;

import screens.*;

class CustomSegment {
    public var x1: Float;
    public var y1: Float;
    public var x2: Float;
    public var y2: Float;

    public function new(parent: Screen, x1: Float, y1: Float, x2: Float, y2: Float) {        
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }
    
    // коллизия между двумя линиями
    public function intersects(x3: Float, y3: Float, x4: Float, y4: Float) {
        var uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
        var uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
        
        if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) return true;
        return false;
    }
    
    public function update(dt: Float) {
    }

}