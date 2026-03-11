Wolfscope
copyright (c) 2019-26 Robin Parmar. MIT license.
 
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
