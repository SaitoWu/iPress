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
  <a href="#" onclick="return QEditor.action(this,\'bold\');" title="Bold"><span class="glyphicon glyphicon-bold"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'italic\');" title="Italic"><span class="glyphicon glyphicon-italic"></span></a> \
  <a href="#" onclick="return QEditor.action(this,\'underline\');" title="Underline"><u>U</u></a> \
  <a href="#" class="qeditor_glast" onclick="return QEditor.action(this,\'strikethrough\');" title="StrikeThrough"><strike>S</strike></a>		 \
  <a href="#" onclick="return QEditor.action(this,\'formatBlock\',\'address\');">Q</a> \
  <a href="#" onclick="return QEditor.action(this,\'insertorderedlist\');"><span class="glyphicon glyphicon-list"></span></a> \
  <a href="#" class="qeditor_glast" onclick="return QEditor.action(this,\'insertunorderedlist\');"><span class="glyphicon glyphicon-list"></span></a> \
  <a href="#" class="qeditor_glast" style="display:none;" onclick="return QEditor.action(this,\'insertimage\',prompt(\'Image URL\'));"><span class="glyphicon glyphicon-picture"></span></a> \
</div>';

QEDITOR_ALLOW_TAGS_ON_PASTE = "div,p,ul,ol,li,hr,br,b,strong,i,em,img,h1,h2,h3,h4,h5,h6,h7"
QEDITOR_DISABLE_ATTRIBUTES_ON_PASTE = ["style","class","id","name","width","height"];

var QEditor = {
	action: function(e, a, p) {
    qeditor_preview = $(".qeditor_preview",$(e).parent().parent());
    qeditor_preview.focus();

		if (p == null) {
			p = false;
		}
    if(a == "insertcode"){
      alert("TODO: inser [code][/code]");
    }
    else {
  		document.execCommand(a, false, p);
    }
    if(qeditor_preview != undefined){
      qeditor_preview.change();
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
					var preview_editor = $('<div class="qeditor_preview clearfix" style="overflow:scroll;" contentEditable="true"></div>');
	        preview_editor.html(obj.val());
          preview_editor.addClass(obj.attr("class"));
	        obj.after(preview_editor);
	        preview_editor.change(function(){
	          var pobj = $(this);
	          var t = pobj.parent().find('.qeditor');
	          t.val(pobj.html());
	        });
          preview_editor.on("paste",function(){
            var txt = $(this);
            setTimeout(function () {
              var els = txt.find("*");
              for (var i = 0; i < QEDITOR_DISABLE_ATTRIBUTES_ON_PASTE.length; i ++) {
                var attrName = QEDITOR_DISABLE_ATTRIBUTES_ON_PASTE[i];
                els.removeAttr(attrName);
              }
              els.find(":not("+ QEDITOR_ALLOW_TAGS_ON_PASTE +")").replaceWith(function(){
                $(this).html();
              });
            },100);
          });
	        preview_editor.keyup(function(){ $(this).change(); });
	        obj.hide();
	        obj.wrap('<div class="qeditor_border"></div>');
	        obj.after(preview_editor);
	        QEditor.renderToolbar(preview_editor);
				}
      });
    }
  };
})(jQuery);