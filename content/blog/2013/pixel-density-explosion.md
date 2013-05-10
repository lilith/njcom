Date: Apr 10 2013

# The Pixel Density Explosion

Back in [mid-2012, we didn't have *that* many unique pixel density values](http://www.quirksmode.org/blog/archives/2012/07/more_about_devi.html); just `1`, `1.5`, `2`, and `2.25`, plus variations based on zoom size. Since then, we've had an explosion of devices with high-resolution displays (adding 1.75, 2.5, 3, etc) and this continues to grow.

I'm very concerned that the current `srcset` and `picture` elements are jumping on the `dppx`/ pixel density bandwagon without considering that they're introducing *exponential* complexity for authors. If `v` is viewport sizes in virtual pixels we optimize for and `d` is pixel densities we want to support crisply without waste, we must describe `v*n` number of images. This is untenable.

Photographs **don't care about dppx**. Photos are crisp if there's a 1-1 mapping between physical and bitmap pixels. If the browser has decent scaling, additional bitmap pixels are acceptable too. It's generally a *good* thing if your eyes can't make out the individual pixels of a photo. 

I also prefer to pinch-zoom in on a semantic photo instead of having the context cropped automatically for me. Perhaps others find it natural to have content changed on browser resize, but I find it unsettling.

Note I used the term `photographs`, not `images`. Text and layout *really* need virtual pixels and the `dppx` abstraction to ensure readability and usability - as do images that contain text or affect layout (although you should be using SVG).

## What this means in terms of markup

This is where we're headed with the current picture spec and the pixel density explosion. 

We're only handling the standard Bootstrap breakpoints, assuming a full-screen image, and the 6 most popular pixel densities here. We're not even handling smaller mobile devices well here, nor are we doing a great job of bandwidth optimization. We're just doing a somewhat acceptable job of delivering a crisp image that doesn't waste more than 60% of the bandwidth used.

    <picture>
       <source media="(min-width: 941px)" srcset="http://cdn.company.com/site/images/1200_x1.jpg 1x, http://cdn.company.com/site/images/1200_x1_5.jpg 1.5x http://cdn.company.com/site/images/1200_x2.jpg 2x http://cdn.company.com/site/images/1200_x2_25.jpg 2.25x http://cdn.company.com/site/images/1200_x2_5.jpg 2.5x http://cdn.company.com/site/images/1200_x3.jpg 3x">
       <source media="(min-width: 768px) and (max-width: 940px)" srcset="http://cdn.company.com/site/images/940_x1.jpg 1x, http://cdn.company.com/site/images/940_x1_5.jpg 1.5x http://cdn.company.com/site/images/940_x2.jpg 2x http://cdn.company.com/site/images/940_x2_25.jpg 2.25x http://cdn.company.com/site/images/940_x2_5.jpg 2.5x http://cdn.company.com/site/images/940_x3.jpg 3x">
       <source media="(min-width: 480px) and (max-width: 767px)" srcset="http://cdn.company.com/site/images/767_x1.jpg 1x, http://cdn.company.com/site/images/767_x1_5.jpg 1.5x http://cdn.company.com/site/images/767_x2.jpg 2x http://cdn.company.com/site/images/767_x2_25.jpg 2.25x http://cdn.company.com/site/images/767_x2_5.jpg 2.5x http://cdn.company.com/site/images/767_x3.jpg 3x">
       <source srcset="http://cdn.company.com/site/images/480_x1.jpg 1x, http://cdn.company.com/site/images/480_x1_5.jpg 1.5x http://cdn.company.com/site/images/480_x2.jpg 2x http://cdn.company.com/site/images/480_x2_25.jpg 2.25x http://cdn.company.com/site/images/480_x2_5.jpg 2.5x http://cdn.company.com/site/images/480_x3.jpg 3x">
       <img src="http://cdn.company.com/site/images/480_x1.jpg" alt="">
       <p>Accessible text</p>
    </picture>


### This is not a good direction

So... that's pretty bad for a single image. We're definitely leaving the door open for 'art direction', but is this overhead worth it? 

We've described 24 image URLs with the following physical widths:

* 1200 - 1800 - 2400 - 2700 - 3000 - 3600
* 940 - 1410 - 1880 - 2115 -  2350 - 2820
* 767 - 1150 - 1534 - 1726 - 1917 - 2301
* 480 - 720 - 960 - 1080 - 1200 - 1440

### This is a crazy amount of duplication.

Despite providing so many resolutions, we're only supporting 4 breakpoints well, and either wasting or poorly supporting the rest. This is wasteful.

If we de-duplicate those resolutions, we get 9 sizes, and we can even add '640' to provide more granularity.

* 480 - 640 - 780 - 960 - 1200 - 1440 - 1800 - 2400 - 3000 - 3600

### Speaking in device pixels is good

By describing 'true pixels' instead of virtual pixels, the browser can use the same image and declaration for a 480px 2dppx viewport and a 960 1dppx viewport.

This allows us to reduce asset count by 60%, markup by ~75%, and lower our bandwidth waste tolerance from 60% to 20%.

    <picture>
      <source src="http://cdn.company.com/site/images/3600.jpg" w="3600" />
      <source src="http://cdn.company.com/site/images/3000.jpg" w="3000" />
      <source src="http://cdn.company.com/site/images/2400.jpg" w="2400" />
      <source src="http://cdn.company.com/site/images/1800.jpg" w="1800" />
      <source src="http://cdn.company.com/site/images/1440.jpg" w="1400" />
      <source src="http://cdn.company.com/site/images/1200.jpg" w="1200" />
      <source src="http://cdn.company.com/site/images/960.jpg" w="960" />
      <source src="http://cdn.company.com/site/images/780.jpg" w="780" />
      <source src="http://cdn.company.com/site/images/640.jpg" w="640" />
      <source src="http://cdn.company.com/site/images/480.jpg" w="480" />
       <img src="http://cdn.company.com/site/images/480.jpg" alt="">
       <p>Accessible text</p>
    </picture>

**Isn't that simpler?** And we're supporting a wider variety of viewport sizes and device pixel densities.

### This doesn't preclude media queries or art direction, they have a place

Because pinch-to-zoom is nearly ubiqitous, I feel that it's generally a waste of time to prepare 2 *photographs* of identical dimensions with different content, but there **is a use-case**.

I am NOT advocating the removal of the `media` attribute from `source`, only that we permit a descriptive syntax as shown above, instead of an essentially imperative/declarative method. Images with text *need to be modified for 2dppx and 3dppx displays*; they'll be unreadable as-is. Either `media="(min-device-pixel-ratio:2dppx)"` or `srcset` can be used, but I favor using `media` as it simplifies and flattens the evaluation logic for both the browser and the human mind. It's good to evaluation logic in a single dimension.

### srcset has the same problem.

Solving the `srcset` problem is more difficult (syntatically) if we also wish to support virtual viewport sizes AND pixel density selectors. Suggestions are welcome.

### Clarification on scope.

Unlike [my last proposal regarding the 'picture' element](https://gist.github.com/nathanaeljones/5047077), I'm not trying to address the argument of viewport vs. element context for image URL selection. That's a separate concern I'll write about later. 

For now, assume I'm talking about viewport-based evaluation unless I state otherwise.

This article is about *device pixel ratio* and why the popular use syntax should simply describe bitmap dimensions.




