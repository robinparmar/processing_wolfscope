/*	
	interaction function for keyboard processing
  	uses globals: method, slices
*/

void keyPressed() {
    // no processing
    if (key==' ') {
        println("processing off");
        method = 0;
        return;
    } else if (key=='0') {
        println("kaleidoscope slices off / tiling on");
        method = 1;
    } else if ("123456789".indexOf(key) > -1) {
        slices = 2 * ((int) key -47);

        println("kaleidoscope slices = %d".formatted(slices));
        method = 2;
        background(0);
    }

    // monochrome
    if (key=='m' || key == 'M') {
        println("monochrome toggled");
        fx.setMono(0);
    } else if (key=='<' || key == ',') {
        println("monochrome darker");
        fx.setMono(10);
    } else if (key=='>' || key == '.') {
        println("monochrome lighter");
        fx.setMono(-10);

        // brightness
    } else if (key=='a' || key == 'A') {
        println("brightness reset");
        fx.setBrightness(0);
    } else if (key=='s' || key == 'S') {
        println("brightness darker");
        fx.setBrightness(-10);
    } else if (key=='d' || key == 'D') {
        println("brightness lighter");
        fx.setBrightness(10);

        // chroma flip
    } else if (key=='q' || key == 'Q') {
        println("chroma reset");
        fx.setFlip(0);
    } else if (key=='w' || key == 'W') {
        println("chroma flip Red and Green");
        fx.setFlip(1);
    } else if (key=='e' || key == 'E') {
        println("chroma flip Red and Blue");
        fx.setFlip(2);
    } else if (key=='r' || key == 'R') {
        println("chroma flip Blue and Green");
        fx.setFlip(3);

        // burn
    } else if (key=='z' || key == 'Z') {
        println("chroma burn off");
        fx.setBurn(0);
    } else if (key=='x' || key == 'X') {
        println("chroma burn on (random amount)");
        fx.setBurn(1);

        // refract
    } else if (key=='j' || key == 'J') {
        println("refract reset");
        fx.setRefract(0);
    } else if (key=='k' || key == 'K') {
        println("refract decrease");
        fx.setRefract(-1);
    } else if (key=='l' || key == 'L') {
        println("refract increase");
        fx.setRefract(1);

        // alpha 120, 75,
    } else if (key=='p' || key == 'P') {
        println("transparency reset");
        alpha = 255;
    } else if (key=='[' || key == '{') {
        alpha *= 0.5;
        alpha = constrain(alpha, 4, 255);
        println("transparency decreased to %d".formatted(alpha));
    } else if (key==']' || key == '}') {
        alpha *= 1.8;
        alpha = constrain(alpha, 4, 255);
        println("transparency increased to %d".formatted(alpha));
    }
}
