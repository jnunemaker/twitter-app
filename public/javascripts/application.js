// generic enumeration
Function.prototype.forEach = function(object, block, context) {
  for (var key in object) {
    if (typeof this.prototype[key] == "undefined") {
      block.call(context, object[key], key, object);
    }
  }
};

// globally resolve forEach enumeration
var forEach = function(object, block, context) {
  if (object) {
    var resolve = Object; // default
    if (object instanceof Function) {
      // functions have a "length" property
      resolve = Function;
    } else if (object.forEach instanceof Function) {
      // the object implements a custom forEach method so use that
      object.forEach(block, context);
      return;
    } else if (typeof object.length == "number") {
      // the object is array-like
      resolve = Array;
    }
    resolve.forEach(object, block, context);
  }
};

jQuery.extend(String.prototype, {
  databaseId: function() { return $.trim(this.split('_').last()); }
});

jQuery.extend(Array.prototype, {
  last: function() { return this[this.length-1]; }
});

jQuery.authenticity_token = function() {
  return $('#authenticity_token').attr('content');
};

function log() {
  if (window && window.console && window.console.log)
    for(var i=0, len=arguments.length; i<len; i++)
      console.log(arguments[i]);
};

jQuery(function($) {
  var countdown = $('#countdown');
  var allowed = parseInt(countdown.text());
  $('#text').keydown(function() {
    var length = $(this).val().length;
    countdown.text(allowed - length);
    
    if (length == 0) {
      $('#in_reply_to_status_id').val('');
      var label = $('label[for=text]')
      label.text(label.data('original_text'));
    }
  });
  
  $('a.dm').click(function() {
    window.scrollTo(0, 0);
    $('#text').focus().val('d ' + $(this).attr('rel') + ' ');
    return false;
  });
  
  var label = $('label[for=text]')
  label.data('original_text', label.text());
  
  $('a.reply').click(function() {
    window.scrollTo(0, 0);
    var pieces = $(this).attr('rel').split(':');
    var screen_name = pieces[0];
    var id = pieces[1];
    $('#text').focus().val('@' + screen_name + ' ');
    $('#in_reply_to_status_id').val(id);
    $('label[for=text]').text('Replying to ' + screen_name + "'s tweet #" + id);
    return false;
  });
});