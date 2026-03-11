/*    
    Videocam class
    uses the Processing video library
    can be quirky depending on your system
*/

class Videocam {
    // camera instance
    Capture cam;

    // which camera to use?
    int cameraIndex = 0;

    int w = 640;
    int h = 480;

    // initialise camera list
    Videocam(PApplet parent, int cameraIndex_) {
        cameraIndex = cameraIndex_;

        // interrogate video input
        String[] cameras = Capture.list();

		if (DEBUG) {
            println();
            if (cameras.length == 0) {
                println("There are no cameras available for capture.");
                exit();
            } else {
                println("Available cameras:");
                for (int i=0; i<cameras.length; i++) {
                    println(cameras[i]);
                }
            }
		}
        cam = new Capture(parent, w, h, cameras[cameraIndex]);
        cam.start();
    }

    // read new buffer if available
    boolean read() {
        boolean ok = cam.available();
        if (ok) {
            cam.read();
        }
        return ok;
    }

    // return pixel buffer as PImage
    PImage get() {
        PImage img = createImage(w, h, RGB);
        img.loadPixels();
        img.pixels = cam.pixels;

        return img;
    }

    // return specific pixel from buffer
    color getPixel(int loc) {
        return cam.pixels[loc];
    }
}
