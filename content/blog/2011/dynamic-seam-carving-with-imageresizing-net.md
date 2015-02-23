WP ID: 596
Atom ID: http://nathanaeljones.com/?p=596
Date: Aug 2 2011
Tags: image-resizing
Flags: hidden

# Dynamic seam carving with ImageResizer

[Version 3.0.11](http://imageresizing.net/releases/3-0-11) version of [ImageResizer](http://imageresizing.net) supports dynamic [seam carving](http://en.wikipedia.org/wiki/Seam_carving) (content-aware image resizing) and [remote image resizing](http://imageresizing.net/plugins/remotereader).


Seam carving allows low-energy (unimportant) parts of the image to be removed in order to shrink an image.

**Original image**

<p>
  <img src="http://img.imageresizing.net/mountain.jpg;width=300"/>
</p>

<strong>Stretched (distorted image) to 300x150</strong>

<p>
  <img src="http://img.imageresizing.net/mountain.jpg;width=300;height=150;stretch=fill"/>
</p>


<strong>Seam carved to 300x150</strong>

<p>
  <img src="http://img.imageresizing.net/mountain.jpg;width=300;height=150;carve=true"/>
</p>

<strong>Original image</strong>

<p>
  <img src="http://img.imageresizing.net/night-bridge.jpg;width=300"/>
</p>

<strong>Stretched (distorted image) to 150x300</strong>

<p>
  <img src="http://img.imageresizing.net/night-bridge.jpg;width=150;height=300;stretch=fill"/>
</p>


<strong>Seam carved to 150x300</strong>

<p>
  <img src="http://img.imageresizing.net/night-bridge.jpg;width=150;height=300;carve=true"/>
</p>

While not a panacea, seam carving can be very useful when you need to change the aspect ratio of an image without cropping any features out. 

The Image Resizer's implementation of seam carving is based on  <a href="https://sites.google.com/site/brainrecall/cair">CAIR</a>, which allows for extremely high-performance seam carving.

