package entities;

import screens.*;

class Ground {

    var perlin = new hxd.Perlin();
    var seed: Int;
    var chunkSize = 100;
    var chunks: Map<Int, Chunk>;
    var lander: Lander;
    var screen: Game;

    public function new(parent: Game, lander: Lander) {
        seed = Random.int(0, 1000);
        chunks = new Map<Int, Chunk>();
        this.lander = lander;
        this.screen = parent;
    }

    private function checkChunks() {
        var relativePosition = lander.x/hxd.Window.getInstance().width;
        var id = Math.floor(relativePosition);
        for (key in chunks.keys()) if (key != id-1 && key != id && key != id+1) {
            chunks[key].clear();
            chunks[key] = null;
            chunks.remove(key);
        }
        for (i in id-1...id+2) if (!chunks.exists(i)) chunks[i] = new Chunk(screen, i, seed+i, chunkSize);
    }

    public function update(dt: Float) {
        checkChunks();
        var size = Random.float(1.5, 3.);
        for (chunk in chunks) chunk.update(dt, lander, size);
    }
}