Date: April 8 2013

# Why don't we have CSS 'image-fit' yet?

When both width and height are specified for an image, the standard behavior is to *stretch* the image to fit the new aspect ratio. 

I'm highly curious if image distortion has *ever* been a useful behavior pattern.

Why doesn't 'image-fit' already exist?


    image-fit: stretch; /* 'stretch-scale' The current default */

    image-fit: crop; /* 'crop-scale' Scale down to largest dimension, crop to fit new aspect ratio */
    image-fit: crop-downscale; /* Pad instead of upscaling if the edges don't reach borders*/
    image-fit: crop-noscale; /* Crop without scaling */

    image-fit: pad; /* Scale to fit bounding box, pad other axis*/
    image-fit: pad-downscale; /* Expand the canvas instead of upscaling a tiny image */


After 6 years of working with [ImageResizer customers](http://imageresizing.net), I've identified the above 6 'fit modes' as being 'in real-world use'. Only `crop`, `pad`, and `pad-downscale` are very popular, however. 


The above fit modes do not attempt to address alignment or focus points. Ideally, we would standardize an image metadata tag to describe the focus points within the image; however, a CSS-based approach is actually feasbile.

    image-fit-align: x-percent, y-percent;  /* Center the given point within the bounding box*/

    image-fit-preserve: x-pct,y-pct, x2pct,ypct, ...; /* Never crop off any of these points */


The simply polygon math required to implement all these features only requires about 60 lines of code (ImageResizer implements a superset of these features). I'm willing to assist any browser implementors. 

### 'image-fit' and friends can pave the way for simpler solutions to responsive imaging

A current point of contention between proponents of various responsive imaging solutions is 'element' vs 'viewport' media query evaluation. I think both are important, but element/context-based source selection faces a unique challenge: how do we prevent infinite loops? 

The premise everyone assumes is that the only fit behavior possible for `img` or `picture` is `stretch-scale`. If we solve this problem, we can force boundaries on images without destroying aspect ratio.


### While we're at it..

  It would be nice to tell browsers which filters will work best with our images. 

    image-scale-filter: bicubic-sharper | bicubic-smoother | bilinear | nearest-neighbor | fant; 









