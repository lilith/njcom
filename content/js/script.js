
jQuery(function($){
  $(".tweets").tweet({
    join_text: "auto",
    username: "nathanaeljones",
    avatar_size: 32,
    count: 4,
    auto_join_text_default: "",
    auto_join_text_ed: "",
    auto_join_text_ing: "",
    auto_join_text_reply: " I replied ",
    auto_join_text_url: "",
    loading_text: "loading tweets..."
  });
});



window.log = function(){
  log.history = log.history || [];  
  log.history.push(arguments);
  arguments.callee = arguments.callee.caller;  
  if(this.console) console.log( Array.prototype.slice.call(arguments) );
};
(function(b){function c(){}for(var d="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),a;a=d.pop();)b[a]=b[a]||c})(window.console=window.console||{});




$(function() {
  $('pre[class*="brush:"], pre[name="code"]').each(function(i, e) {
    e = $(e);
    e.prop('name',null);
    var code = e.children('code');
    if (code.length < 1) e.wrapInner('<code/>');
    code = e.children('code');

    var cls = e.prop('class');
    if (cls){
      var match = (/brush\:([a-zA-Z-0-9]+)/i).exec(cls);
      var rename = {'jscript':'javascript'}
      if (match) {
          code.addClass(rename[match[1]] || match[1]);
      }
    }

  });
    
  $('pre code').each(function(i,e){ hljs.highlightBlock(e, '    ');});


});

$('a[rel="tooltip"], .with-tooltips a').tooltip();

if (typeof(loadq) !== 'undefined'){
	for (var i = 0; i < loadq.length; i++)
		$(loadq[i]);
}
