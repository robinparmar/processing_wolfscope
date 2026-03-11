/*   
	Effects class
	processes image input with a variety of FX
	attempts to be as efficient as reasonable
*/

class Effects {
    int wide;
    float temp;

    boolean monoOn = false;
    int monoThresh = 127;

    boolean flipRG = false;
    boolean flipRB = false;
    boolean flipBG = false;

    int brightness = 0;

    boolean burnOn = false;
    color burnThreshold;

    int warp = 0;
    int alpha = 120;

    PImage process(PImage img) {
        float r, g, b;
        color c;
        wide = img.width;

        img.loadPixels();

        // walk through every incoming pixel
        for (int loc=0; loc<img.width * img.height; loc++ ) {
            c = img.pixels[loc];

            r = c >> 16 & 0xFF;
            g = c >> 8 & 0xFF;
            b = c & 0xFF;

            if (flipRG) {
                temp = r;
                r = g;
                g = temp;
            }
            if (flipRB) {
                temp = r;
                r = b;
                b = temp;
            }
            if (flipBG) {
                temp = b;
                b = g;
                g = temp;
            }

            if (brightness != 0.) {
                r += brightness;
                g += brightness;
                b += brightness;
                r = constrain(r, 0., 255.);
                g = constrain(g, 0., 255.);
                b = constrain(b, 0., 255.);
            }

            if (burnOn) {
                r = r > (burnThreshold >> 16 & 0xFF) ? 255 : r;
                g = g > (burnThreshold >> 8 & 0xFF)  ? 255 : g;
                b = b > (burnThreshold & 0xFF)       ? 255 : b;
            }

            // rebuild colour for final effects
            c = color(r, g, b);

            if (monoOn) {
                if (brightness(c) > monoThresh) {
                    c = color(240);
                } else {
                    c = color(15);
                }
            }

            img.pixels[loc] = c;
        }

        // warp after other effects
        if (warp != 0) {
            int loc;

            for (int x=0; x<img.width; x++ ) {
                for (int y=0; y<img.height; y++ ) {
                    loc = x + y * img.width;
                    c = img.pixels[loc];

                    int target = loc + floor(warp * img.width * 10);
                    target = target % (img.width * img.height);
                    img.pixels[loc] = img.pixels[target];
                }
            }
        }

        return img;
    }

    // set monochrome mode
    void setMono(int i) {
        if (i==0) {
            monoOn = !monoOn;
            monoThresh = 127;
        } else {
            monoThresh += i;
            monoThresh = constrain(monoThresh, 0, 255);
        }
    }

    // set brightness
    void setBrightness(int i) {
        if (i == 0) {
            brightness = 0;
        } else {
            brightness += i;
        }
    }

    // chroma flip
    void setFlip(int i) {
        switch(i) {
        case 0:
            // reset
            flipRG = false;
            flipRB = false;
            flipBG = false;
            break;
        case 1:
            flipRG = !flipRG;
            break;
        case 2:
            flipRB = !flipRB;
            break;
        case 3:
            flipBG = !flipBG;
            break;
        }
    }

    // chroma burn
    void setBurn(int i) {
        if (i==0) {
            burnOn = false;
        } else {
            burnOn = true;
            burnThreshold = color(random(180), random(180), random(180));
        }
    }

    // refract image
    void setRefract(int i) {
        if (i == 0) {
            warp = 0;
        } else {
            warp += i;
            warp = constrain(warp, 0, wide);
        }
    }
}
