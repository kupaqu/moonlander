package entities;

import screens.*;

class Ground {

    var perlin = new hxd.Perlin();
    var seed: Int;
    var numOfSegments = 100;
    var segments: Array<CustomSegment>;

    public function new(parent: Screen) {
        seed = Random.int(0, 1000);
        generateGround(parent);
    }

    private function generateGround(parent: Screen) {
        segments = new Array<CustomSegment>();
        
        // генерация точек по высоте
        var points = [];
        for (i in 0...numOfSegments+1) {
            var y = ((perlin.perlin1D(seed, i/(numOfSegments/10), 3))+1)/2;
            points.push(y);
        }
        
        // генерация посадочных мест
        for (i in 3...points.length) {
            var rand = Random.float(0., 1.);
            if (rand <= 0.05) points[i] = points[i-1] = points[i-2] = points[i-3];
        }

        // генерация сегментов
        for (i in 1...points.length) {
            var x1 = (i-1)*(hxd.Window.getInstance().width/numOfSegments);
            var y1 = points[i-1]*300;
            var x2 = i*(hxd.Window.getInstance().width/numOfSegments);
            var y2 = points[i]*300;

            var segment = new CustomSegment(parent, x1, y1, x2, y2);
            segments.push(segment);
        }

    }

    public function update(dt: Float) {
        var size = Random.float(.5, 2.);
        for (segment in segments) {
            segment.update(dt, size);
        }
    }
}