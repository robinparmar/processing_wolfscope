/*
	display functions:
		method 0 = simple upscaling (useful for testing)
 		method 1 = tiling
 		method 2 = kaleidoscope
 
	uses globals: alpha

	algorithm (c) 2010 David Buchmann, GNU General Public License
 	https://github.com/dbu/kaleidoscope
*/

void kaleidoscope(PImage img) {
    // increase angle slightly to avoid unsightly gaps
    float correction = 0.1;

    // radius based on minimal dimension
    int radius = min(width, height)/2;

    // amount of circle per slice
    float arc = TWO_PI / slices;

    // mask must be same size as image it is applied to
    // shape is a centered ellipse
    PGraphics mask = createGraphics(img.width, img.height);

    mask.beginDraw();
    mask.background(0);
    mask.noStroke();
    mask.arc(0, 0, 2*radius, 2*radius, 0, arc + correction);
    mask.endDraw();

    // apply mask
    img.mask(mask);

    // every other segment is reflected, so draw in two passes
    translate(width/2, height/2);

    // regular segments
    for (int i=0; i<slices; i+=2) {
        pushMatrix();
        rotate(i * arc);
        translate(-radius, -radius);
        tint(255, alpha);
        image(img, radius, radius);
        popMatrix();
    }

    // segments mirrored on x-axis
    for (int i=0; i<slices; i+=2) {
        pushMatrix();
        scale(-1, 1);
        rotate(i * arc - PI);
        translate(radius, -radius);
        tint(255, alpha);
        image(img, -radius, radius);
        popMatrix();
    }
}

// places image four times, reflected in x and y axis
void tile(PImage img) {
    float xActual, yActual;
    float wPixel = wScale;
    float hPixel = hScale;

    for (int x=0; x<img.width; x++ ) {
        for (int y=0; y<img.height; y++ ) {
            fill(img.pixels[x + y * img.width], alpha);

            // scale up to full screen size
            xActual = float(x) * wScale * 0.5;
            yActual = float(y) * hScale * 0.5;

            // the image is draw in each quadrant, each pixel an ellipse
            ellipse(xActual, yActual, wPixel, hPixel);
            ellipse(width - xActual-2, yActual, wPixel, hPixel);
            ellipse(xActual, height -yActual-2, wPixel, hPixel);
            ellipse(width -xActual-2, height -yActual-2, wPixel, hPixel);
        }
    }
}

// places image just once, scaled up to screen size
void simple(PImage img) {
    background(0);

    float x, y;
    float scale = min(wScale, hScale);

    // centre
    float xOffset = (width - (scale * img.width)) / 2;
    float yOffset = (height - (scale * img.height)) / 2;
    translate(xOffset, yOffset);

    for (int i=0; i<img.width; i++ ) {
        for (int j=0; j<img.height; j++ ) {
            fill(img.pixels[i + j * img.width]);

            // scale up to full screen size
            x = float(i) * scale;
            y = float(j) * scale;

            circle(x, y, scale+1);
        }
    }
}
