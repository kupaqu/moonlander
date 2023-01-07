package entities;

import screens.*;

class Chunk extends h2d.Graphics {
    public var id: Int;
    var perlin = new hxd.Perlin();
    var seed: Int;
    var chunkSize: Int;
    var segments: Array<CustomSegment>;
    var screen: Game;
    var scaleDist = 150;

    public function new(parent: Game, id: Int, seed: Int, chunkSize: Int) {
        super(parent);
        this.id = id;
        this.seed = seed;
        this.chunkSize = chunkSize;
        this.segments = new Array<CustomSegment>();
        this.screen = parent;
        generate(parent);
    }

    private function generate(parent: Screen) {
        // генерация точек по высоте
        var points = [];
        for (i in 0...chunkSize+1) {
            var h = ((perlin.perlin1D(seed, i/(chunkSize/10), 5))+1)/2;
            points.push(h);
        }
        // генерация посадочных мест
        for (i in 3...points.length) {
            var rand = Random.float(0., 1.);
            if (rand <= 0.05) points[i] = points[i-1] = points[i-2] = points[i-3];
        }
        // генерация сегментов
        for (i in 1...points.length) {
            var x1 = id*hxd.Window.getInstance().width+(i-1)*(hxd.Window.getInstance().width/chunkSize);
            var y1 = points[i-1]*300;
            var x2 = id*hxd.Window.getInstance().width+i*(hxd.Window.getInstance().width/chunkSize);
            var y2 = points[i]*300;
            
            var segment = new CustomSegment(parent, x1, y1, x2, y2);
            segments.push(segment);
        }
    }

    public function update(dt: Float, lander: Lander, size: Float) {
        
        var landerPoint = new h2d.col.Point(lander.x, lander.y);
        var minDist = Math.POSITIVE_INFINITY;
        
        clear();
        for (segment in segments) {
            if (segment.intersects(lander.getPoly())) {
                if (segment.landable
                    && lander.rotation <= lander.acceptableAngle
                    && lander.rotation >= -lander.acceptableAngle) screen.mode = 1;
                else screen.mode = 2;
            }  
            if (segment.landable) lineStyle(size, 0x1BEC64); // место для посадки
            else lineStyle(size, 0xD1CBCB);

            moveTo(segment.x1, segment.y1);
            lineTo(segment.x2, segment.y2);

            var dist = segment.dist(landerPoint);
            if (dist < minDist) minDist = dist;
        };
        
        if (lander.x >= segments[0].x1 && lander.x <= segments[segments.length-1].x2) {
            if (minDist < scaleDist) {
                screen.camera.scaleX = 1.5;
                screen.camera.scaleY = 1.5;
            } else if (minDist >= scaleDist) {
                screen.camera.scaleX = 0.75;
                screen.camera.scaleY = 0.75;
            }
        }

    }
}