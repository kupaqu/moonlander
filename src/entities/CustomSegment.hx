package entities;

import screens.*;

class CustomSegment {
    public var x1: Float;
    public var y1: Float;
    public var x2: Float;
    public var y2: Float;
    var mid: h2d.col.Point;

    public function new(parent: Screen, x1: Float, y1: Float, x2: Float, y2: Float) {        
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
        mid = new h2d.col.Point((x1+x2)/2, (y1+y2)/2);
    }
    
    // коллизия между двумя линиями
    public function collide(x3: Float, y3: Float, x4: Float, y4: Float) {
        var uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
        var uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
        
        if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) return true;
        return false;
    }

    public function intersects(poly: h2d.col.Polygon) {
        var up = collide(poly.points[0].x, poly.points[0].y, poly.points[1].x, poly.points[1].y);
        var right = collide(poly.points[1].x, poly.points[1].y, poly.points[2].x, poly.points[2].y);
        var bottom = collide(poly.points[2].x, poly.points[2].y, poly.points[3].x, poly.points[3].y);
        var left = collide(poly.points[3].x, poly.points[3].y, poly.points[0].x, poly.points[0].y);
        return up || right || bottom || left;
    }

    public function dist(point: h2d.col.Point) {
        return mid.distance(point);
    }

}