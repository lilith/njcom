
ResizeSettings = function(){
	this.s = {};
};

ResizeSettings.prototype.srcFlip = function(x,y){
	if (x === undefined && y === undefined){
		var f = this.s.srcFlip ? this.s.srcFlip : "none";
		var x = f == 'both' || f.indexOf('h') > -1 || f.indexOf('x') > -1;
		var y = f == 'both' || f.indexOf('v') > -1 || f.indexOf('y') > -1;
		return {x:x,y:y};
	}else{
		this.s.srcFlip = (x || y) ? ((x ? "x" : "") + (y ? "y" : "")) : "none";
	}	
}

ResizeSettings.prototype.srcFlipX = function(x){
	if (x === undefined) return this.srcFlip().x;
	else this.srcFlip(x,this.srcFlip().y);
};
ResizeSettings.prototype.srcFlipY = function(y){
	if (y === undefined) return this.srcFlip().y;
	else this.srcFlip(this.srcFlip().x,y);
};



var sections = {};

var ui = {}
ui.btn = function(text,icon){
	return $("<a>" + text + "</a>").addClass("ui-state-default ui-corner-all").css("margin","2px").css("padding","4px 0").button({ text:text, icons: {primary:icon}});
};

sections.first = function(img){
	var c = $("<div />").css("height","100px");
	c.append(ui.btn("Flip Vertical",'.ui-icon-triangle-2-n-s'));
	c.append("<p/>");
	return c;
};

$(function(){
	$("img[alt='edit']").click(function(e){
		e = $(this);
		var bg = $("<div />").css("width","100%").css("height","100%");
		$(window).resize(function(){
			TINY.box.size($(window).width() -90,  $(window).height() -90);
		});
		
		
		var tr = $("<tr />").appendTo($("<table />").appendTo(bg).css("width","100%").css("height","100%").css("opacity","1").css("filter","Alpha(Opacity=100)"));
		var ltd = $("<td />").appendTo(tr).css("text-align","center").css("vertical-align","middle");
		var ltr = $("<td />").appendTo(tr).css("text-align","center").css("vertical-align","middle").css("width","300px");
		
		var img = $("<img />").attr("src",e.attr("src")).appendTo(ltd);
		
		var panel = $("<div/>").css('height','100%');
			
		
		
		var addSection = function(title, content, callback){
			var header = $("<h3 />").append($("<a href='#'/>").append(title)).appendTo(panel);
			panel.append(content);
			panel.bind('accordionchangestart', function(event, ui) {
				  if (ui.newHeader == header) callback();
				});
		};
		
		
		
		
		addSection("Rotate & Flip", sections.first(img),function(){});
		
		addSection("Rotate & Flip", sections.first(img),function(){});
		
		
		panel.appendTo(ltr).accordion({ clearStyle: true});
		
		TINY.box.show({html:bg[0], width:$(window).width() -90, height: $(window).height() -90});
	});
});