	/*

	Copyright (c) 2011 Joran de Raaff, www.joranderaaff.nl

	Permission is hereby granted, free of charge, to any person obtaining
	a copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
	OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
	WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

	*/
		
	//this is the image displayed when there is no support for canvas
	var defaultImageSrc = "/assets/images/charRendered.png";
	//this is the default scale to render the image
	var scale = 1;

	function renderMCSkins(classNameIn, scaleIn, replacementImageIn)
	{
		scale = scaleIn || scale;
		defaultImageSrc = replacementImageIn || defaultImageSrc;
		
		//we need custom support for IE, because it doesn't support getElementsByClassName
		if (navigator.appName=="Microsoft Internet Explorer") {
			var skinImages = getElementsByClassName(classNameIn, 'img');
		} else {
			var skinImages = document.getElementsByClassName(classNameIn);
		}
		
		var canvasSupported = supportsCanvas();
		
		//walk trough the images
		for(var i in skinImages)
		{
			var skin = skinImages[i];
			
			//if canvas is supported, we render the image to a skin
			if(canvasSupported) {
				if(skin.complete) {
					renderSkin(skin);
				}
				else {
					skin.onload = handleSkinLoaded;
					skin.onerror = handleImageError;
				}
			} else {
				//if it's not supported, we use the default image
				skin.src = defaultImageSrc;
			}
		}
	}

	function handleSkinLoaded() {
		renderSkin(this);
	}

	function handleImageError() {
		//create replacement image
		var replacement = new Image();
		replacement.src = defaultImageSrc;
		//we assign the same classname the image has, for CSS purposes
		replacement.setAttribute('class', this.getAttribute('class'));
		this.parentNode.replaceChild(replacement, this);
	}

	function renderSkin(skinImage) {
		//we create a new canvas element
		var canvas = document.createElement('canvas');
		canvas.width = 16 * scale;
		canvas.height = 32 * scale;
		//we assign the same classname the image has, for CSS purposes
		canvas.setAttribute('class', skinImage.getAttribute('class'));
		var context = canvas.getContext("2d");
		var s = scale;
		//draw the head
		context.drawImage(skinImage, 8,  8,  8, 8,  4*s,  0*s,  8*s, 8*s);
		//draw the body
		context.drawImage(skinImage, 20, 20, 8, 12, 4*s,  8*s,  8*s, 12*s);
		//draw the left leg
		context.drawImage(skinImage, 4,  20, 4, 12, 4*s,  20*s, 4*s, 12*s);
		//draw the right leg
		context.drawImage(skinImage, 4,  20, 4, 12, 8*s,  20*s, 4*s, 12*s);
		//draw the left arm
		context.drawImage(skinImage, 44, 20, 4, 12, 0*s,  8*s,  4*s, 12*s);
		//draw the right arm
		context.drawImage(skinImage, 52, 20, 4, 12, 12*s, 8*s,  4*s, 12*s);

		//we replace the image with the canvas
		skinImage.parentNode.replaceChild(canvas, skinImage);
	}

	//helper function for IE
	function getElementsByClassName(className, tag, elm){
		var testClass = new RegExp("(^|\\s)" + className + "(\\s|$)");
		var tag = tag || "*";
		var elm = elm || document;
		var elements = (tag == "*" && elm.all)? elm.all : elm.getElementsByTagName(tag);
		var returnElements = [];
		var current;
		var length = elements.length;
		for(var i=0; i<length; i++){
			current = elements[i];
			if(testClass.test(current.className)){
				returnElements.push(current);
			}
		}
		return returnElements;
	}

	//helper function to check canvas support
	function supportsCanvas() {
		canvas_compatible = false;
		try {
				canvas_compatible = !!(document.createElement('canvas').getContext('2d')); // S60
				} catch(e) {
				canvas_compatible = !!(document.createElement('canvas').getContext); // IE
		} 
		return canvas_compatible;
	}