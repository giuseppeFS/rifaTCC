// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.mask
//= require bootstrap-sprockets
//= require rails-ujs
//= require turbolinks
//= require_tree .

$.jMaskGlobals.watchDataMask = true;

$(document).on('turbolinks:load', function(){
  $(".alert").delay(2000).slideUp(500, function(){
    $(".alert").alert('close');
  });

  $("form.has-validation-return").bind("ajax:error", function(data){
      var objResponse = data.detail[0];
      doInputErrorMessages(objResponse.model, objResponse.error);
    });
  });


function doInputErrorMessages(model, errors_json) {
  Object.keys(errors_json).forEach(function(key) {
    document.getElementsByName(model + '[' + key + ']')[0].className += ' is-invalid';
    $('#' + key + '_feedback').html(errors_json[key].join(','));
  })
}
