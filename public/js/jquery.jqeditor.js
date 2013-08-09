/* 
 * QEditor
 *
 * This is a simple Rich Editor for web application, clone from Quora.
 * Author: 
 *  Jason Lee <huacnlee@gmail.com>
 *
 * Using:
 *
 *    $("textarea").qeditor();
 *
 * and then you need filt the html tags,attributes in you content page.
 * In Rails application, you can use like this:
 * 
 *    <%= sanitize(@post.body,:tags => %w(strong b i u strike ol ul li address blockquote br div), :attributes => %w(src)) %>
 *
 */
QEDITOR_TOOLBAR_HTML = '\<div class="qeditor_toolbar"> \
  <a href="#" onclick="return QEditor.action(this,\'bold\');" title="Bold"><span class="icon-bold"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'italic\');" title="Italic"><span class="icon-italic"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'underline\');" title="Underline"><span class="icon-underline"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'strikethrough\');" title="StrikeThrough"><span class="icon-strikethrough"></span></a>		 \
  <span class=\'vline\'></span> \
  <a href="#" onclick="return QEditor.action(this,\'insertorderedlist\');"><span class="icon-list-ol"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'insertunorderedlist\');"><span class="icon-list-ul"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'indent\')"><span class="icon-indent-left"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'outdent\')"><span class="icon-indent-right"></span></a> \
  <span class=\'vline\'></span> \
  <a href="#" onclick="return QEditor.action(this,\'insertHorizontalRule\');"><span class="icon-minus"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'formatBlock\',\'blockquote\');"><span class="icon-quote-left"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'formatBlock\',\'PRE\');"><span class="icon-code"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'createLink\',prompt(\'URL\'));"><span class="icon-link"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'insertimage\',prompt(\'Image URL\'));"><span class="icon-picture"></span></a> \
  <a href="#" onclick="return QEditor.toggleFullScreen(this);" class="pull-right"><span class=\'icon-fullscreen\'></span></a> \
</div>';

QEDITOR_ALLOW_TAGS_ON_PASTE = "div,p,ul,ol,li,hr,br,b,strong,i,em,img,h2,h3,h4,h5,h6,h7"
QEDITOR_DISABLE_ATTRIBUTES_ON_PASTE = ["style","class","id","name","width","height"];

var QEditor = {
	action: function(el, a, p) {
    var editor = $(".qeditor_preview",$(el).parent().parent());
    editor.focus();

		if (p == null) {
			p = false;
		}
    
    document.execCommand(a, false, p);
    
    if(editor != undefined){
      editor.change();
    }

    return false;
	},
  
  toggleFullScreen : function(el) {
    var editor = $(el).parent().parent();
    if (editor.data("qe-fullscreen") == "1") {
      editor.css("width",editor.data("qe-width"))
            .css("height",editor.data("qe-height"))
            .css("top",editor.data("qe-top"))
            .css("left",editor.data("qe-left"))
            .css("position","static")
            .css("z-index",0)
            .data("qe-fullscreen","0");
    }
    else {
      editor.data("qe-width",editor.width())
            .data("qe-height",editor.height())
            .data("qe-top",editor.position().top)
            .data("qe-left",editor.position().left)
            .data("qe-fullscreen","1")
            .css("top",0)
            .css("left",0)
            .css("position","absolute")
            .css("z-index",99999)
            .css("width",$(window).width())
            .css("height",$(window).height());
      
    }
    return false;
  },

	renderToolbar : function(el) {
		el.parent().prepend(QEDITOR_TOOLBAR_HTML);
	},

  version : function(){ return "0.1"; }
};

(function($) {
  $.fn.qeditor = function(options) {
    if (options == false) {
      return this.each(function() {
        var obj = $(this);
        obj.parent().find('.qeditor_toolbar').detach();
        obj.parent().find('.qeditor_preview').detach();
        obj.unwrap();
      });
    }
    else {
      return this.each(function() {
        var obj = $(this);
        obj.addClass("qeditor");
				if (options && options["is_mobile_device"]) {
					var hidden_flag = $('<input type="hidden" name="did_editor_content_formatted" value="no">');
					obj.after(hidden_flag);
				} else {
					var editor = $('<div class="qeditor_preview clearfix" style="overflow:scroll;" contentEditable="true"></div>');
          
          // use <p> tag on enter
          document.execCommand('defaultParagraphSeparator', false, 'p');
          var currentVal = obj.val();
          if (currentVal.trim().length == 0) {
            // TODO: default value need in paragraph
            // currentVal = "<p></p>";
          }
	        editor.html(currentVal);
          editor.addClass(obj.attr("class"));
	        obj.after(editor);
          
	        editor.change(function(){
	          var pobj = $(this);
	          var t = pobj.parent().find('.qeditor');
	          t.val(pobj.html());
	        });
          editor.on("paste",function(){
            var txt = $(this);
            setTimeout(function () {
              var els = txt.find("*");
              for (var i = 0; i < QEDITOR_DISABLE_ATTRIBUTES_ON_PASTE.length; i ++) {
                var attrName = QEDITOR_DISABLE_ATTRIBUTES_ON_PASTE[i];
                els.removeAttr(attrName);
              }
              els.find(":not("+ QEDITOR_ALLOW_TAGS_ON_PASTE +")").contents().unwrap();
            },100);
          });
	        editor.keyup(function(){ 
            $(this).change(); 
          });
          editor.on("click",function(e){
            e.stopPropagation();
          });
	        obj.hide();
	        obj.wrap('<div class="qeditor_border"></div>');
	        obj.after(editor);
	        QEditor.renderToolbar(editor);
				}
      });
    }
  };
})(jQuery);