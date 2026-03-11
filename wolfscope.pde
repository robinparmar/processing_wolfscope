/* //<>//
    Wolfscope
 
	copyright (c) 2019-26 Robin Parmar. MIT license.

CODE REPOSITORY
 
	https://github.com/robinparmar/processing_wolfscope/

DEMO VIDEO

	https://youtu.be/TWduxDEMniY
 
DESCRIPTION

	Wolfscope is a visual system implemented in Processing, that creates
	kaleidoscopic patterns from video camera input, using a variety of
	mirroring, palette shifting, and resolution reduction techniques. 

	Wolfscope is named after the "howl-around" technique, the earliest
	form of video feedback. Watch the original "Doctor Who" 
	titles (1963) for a classic example!

	https://www.youtube.com/watch?v=75V4ClJZME4
 
USE

	The FIRST THING you will need to do is specify the webcam.
	Run the code once to list available cameras to the console.
	Choose these by index number (base zero) in setup().
 
	Don't expect high performance... lag and glitch are the whole idea!
 
CONTROLS

	q w e r		switch colour components: reset RG RB GB
	a s d   	bright: reset - +
	z x     	burn: reset random
 
	p [ ]   	alpha:   off, hi, low
	j k l   	refract: toggle - +
	m < >   	mono:    toggle -  +
 
	spacebar	disables transforms
	0			quad transform
	1-9			kaleidoscope slices
*/

import processing.video.*;
import processing.javafx.*;

Videocam vc;
Effects fx;

// might help!
boolean DEBUG = false;

float wScale, hScale;

// keyboard controls change these
int slices = 8;
int alpha = 255;
int method = 0;

void setup() {
    fullScreen(2);
    noStroke();

    // SPECIFY WEBCAM
    vc = new Videocam(this, 0);
    fx = new Effects();

    // scale up from cam input to screen size
    wScale = float(width)  / float(vc.w);
    hScale = float(height) / float(vc.h);

    if (DEBUG) {
        // banner
        println();
        println("screen: ", width, " x ", height);
        println("cam:    ", vc.w, " x ", vc.h);
        println("scale:  ", wScale, " x ", hScale);
        println();
    }
}

void draw() {
    if (DEBUG) {
        if (frameCount % 100 == 0) {
            println(frameRate);
        }
    }

    if (vc.read()) {
        // grab image buffer
        PImage img = vc.get();

        // process all visual effects
        img = fx.process(img);

        switch(method) {
        case 0:
            simple(img);
            break;
        case 1:
            tile(img);
            break;
        case 2:
            kaleidoscope(img);
            break;
        }
    }
}
