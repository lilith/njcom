Date: July 7 2013

# Reading max-width, cross-browser

### There are 5 basic ways to access max-width

* `element.currentStyle["max-width"]` (IE 6, 9, 10)
* `element.currentStyle.maxWidth` (IE 7, 8, 9, 10 & Opera only)
* `window.getComputedStyle(element,null)["max-width"]` (IE 9, 10, Chrome & Webkit)
* `window.getComputedStyle(element,null).maxWidth` (IE 9, 10, Firefox, Opera, Chrome & Webkit)
* `window.getComputedStyle(element,null).getPropertyValue("max-width")` (IE 9, 10, Firefox, Opera, Chrome & Webkit)

### Test results

All BrowserStack browsers were tested for all methods. If a method is not listed, it returned undefined.

| Browser | method | max-width: 20px | max-width: 20% | max-width: 2em | max-width: 1cm | max-width: 1in |
|:-|:-
| IE6 | currentStyle["max-width"] | 20px | 20% | 2em | 1cm | 1in |
| IE7-IE8 | currentStyle.maxWidth | 20px | 20% | 2em | 1cm | 1in |
| IE9-IE10 | getComputedStyle["max-width"] | 20px | 201.6px | 32px | 37.79px | 96px |
| IE9-IE10 | getPropertyValue("max-width") | 20px | 201.6px | 32px | 37.79px | 96px |
| IE9-IE10 | getComputedStyle.maxWidth | 20px | 201.6px | 32px | 37.79px | 96px |
| IE9-IE10 | currentStyle["max-width"] | 20px | 20% | 2em | 1cm | 1in |
| IE9-IE10 | currentStyle.maxWidth | 20px | 20% | 2em | 1cm | 1in |
| Firefox 3.6-23 | getComputedStyle.maxWidth | 20px | 201.6px | 32px | 37.8px | 96px |
| Firefox 3.6-23 | .getPropertyValue("max-width") | 20px | 201.6px | 32px | 37.8px | 96px |
| Opera 11.6-12.15 | getComputedStyle.maxWidth | 20px | 201px | 32px | 38px | 96px |
| Opera 11.6-12.15 | .getPropertyValue("max-width") | 20px | 201px | 32px | 38px | 96px |
| Opera 11.6-12.15 | currentStyle.maxWidth | 20px | 20% | 2em | 1cm | 1in |
| Chrome 25-28 (win, osx) | getComputedStyle["max-width"] | 20px | 20% | 32px | 37.7952766418457px | 96px |
| Chrome 25-28 (win, osx) | .getPropertyValue("max-width") | 20px | 20% | 32px | 37.7952766418457px | 96px |
| Chrome 25-28 (win, osx) | getComputedStyle.maxWidth | 20px | 20% | 32px | 37.7952766418457px | 96px |
| All other webkit | getComputedStyle["max-width"] | 20px | 20% | 32px | 37px | 96px |
| All other webkit | .getPropertyValue("max-width") | 20px | 20% | 32px | 37px | 96px |
| All other webkit | getComputedStyle.maxWidth | 20px | 20% | 32px | 37px | 96px |

The [test page can be found here](http://imazen.github.io/slimmage/teststyle.html).

*All other webkit* browsers tested: 

* Chrome 14-19, OS X & Windows
* Safari 5.1 & 6 (all platforms)
* iPad 2, iPhone 4S, iPhone 5, iPad 3, iPad mini (Mobile Safari 5, 5.1, 6)
* Amazon Kindle Fire 2, Kindle Fire HD 8.9
* Motorola Droid 4, Razr, Razr Maxx HD, Atrix HD, 
* Samsung Galaxy S, S II, Note, S II, Note II, Tab 2 10.1, Note 10.1, Nexus, 
* Google Nexus 7
* HTC Wildfire, Evo 3D, One X
* LG Nexus 4, Optimus 3D
* Sony Xperia Topo

### Additional notes

[Firefox 3.6 requires you specifiy null](https://developer.mozilla.org/en-US/docs/Web/API/window.getComputedStyle) (or a psuedoselector) as the second parameter of getComputedStyle.

I tested getFloatValue, but found it highly inconsistent. It's also designed to throw errors on percentages and non-convertible units. It only operates smoothly under Firefox.

`window.getComputedStyle(element,null).getPropertyCSSValue("max-width").getFloatValue(5)` 


## Getting a max-width value (cross-browser)

Both `window.getComputedStyle(element,null).maxWidth`  and `window.getComputedStyle(element,null).getPropertyValue("max-width")` are supported identically by all the browsers I tested. It's your pick on which to use.

You can fall back to `currentStyle.maxWidth` for IE 7/8, and finally `currentStyle["max-width"]` for IE6.

The following code returns values on all the browsers tested above. We ran it on DomContentReady, load, or onload, depending on browser support.

    var getCssValue = function(target, hyphenProp){
      var val = typeof(window.getComputedStyle) != "undefined" && window.getComputedStyle(target, null).getPropertyValue(hyphenProp);
      if (!val && target.currentStyle){
        val = target.currentStyle[hyphenProp.replace(/([a-z])\-([a-z])/, function(a,b,c){ return b + c.toUpperCase();})] || target.currentStyle[hyphenProp];
      }
      return val;
    };

## Converting all CSS width units into pixels (cross-browser)

If you only support IE9 and higher, you can get by with parsing only pixels and percentages. For IE6-8, you'll need to implement parsing for all units you wish to support, as there's no conversion provided for you.

Evaluating percentages for [max-width is tricky](
https://developer.mozilla.org/en-US/docs/Web/CSS/max-width), as every css property has slightly different rules for the evaluation, and it is highly dependent on layout context.

Thankfully, there's a pretty straightforward way to convert units in context. It won't handle absolute positioning and some other edge cases, but that could be added without too much fuss.

    var getCssPixels = function(target, hyphenProp){
      var val = getCssValue(target,hyphenProp);

      //We can return pixels directly, but not other units
      if (val.slice(-2) == "px") return parseFloat(val.slice(0,-2));

      //Create a temporary sibling div to resolve units into pixels.
      var temp = document.createElement("div");
      temp.style.overflow = temp.style.visibility = "hidden"; 
      target.parentNode.appendChild(temp);  
      temp.style.width = val;
      var pixels = temp.offsetWidth;
      target.parentNode.removeChild(temp);
      return pixels;
    };


[Here's the test page showing these 2 functions operating on all the browsers mentioned above](http://imazen.github.io/slimmage/test-reading-maxwidth.html)


### What was this all for? [Slimmage.js, a sane responsive images solution](http://github.com/imazen/slimmage).



