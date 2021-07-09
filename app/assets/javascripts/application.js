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
//= require jquery-ui
//= require jquery-ui/i18n/datepicker-pt-BR
//= require Chart.min
//= require dropzone
//= require bootstrap-sprockets
//= require rails-ujs
//= require turbolinks
//= require_tree .

$.jMaskGlobals.watchDataMask = true;

var raffleImages;

$(document).on('turbolinks:load', function(){

  setAlertbehaviour();
  attachRaffleFilesBeforeSubmit();
  attachFormValidationReturn();
  doDisableFrom();
  doInputFormating();
  doChartInitialization();
  doDropZoneInitialization();

});

function urltoFile(url, filename, mimeType){
  return (fetch(url)
    .then(function(res){return res.arrayBuffer();})
    .then(function(buf){return new File([buf], filename,{type:mimeType});})
    );
  }

function setAlertbehaviour(){
    $(".alert").delay(2000).slideUp(500, function(){
    $(".alert").alert('close');
  });
}

function attachFormValidationReturn(){
    $("form.has-validation-return").bind("ajax:error", function(data){
    var objResponse = data.detail[0];
    doInputErrorMessages(objResponse.model, objResponse.error);
  });
}

function attachRaffleFilesBeforeSubmit(){
  $('#newRaffleForm').submit(function(e){
    e.preventDefault();
    e.stopPropagation();

    var formData = new FormData ($('#newRaffleForm')[0]);

    raffleImages.getAcceptedFiles().forEach(function(e,i){
       formData.append('images['+i+']', e);
    });

    $.ajax({
        type: 'POST',
        url: $('#newRaffleForm').attr('action'),
        data: formData ,
        processData: false,
        contentType: false,

        error: function (response, error) {
          var objResponse = response.responseJSON;
          doInputErrorMessages(objResponse.model, objResponse.error);
        }
    });
  });

}


function doDropZoneInitialization() {
  if ($('#raffleImages').length) {
  Dropzone.options.raffleImages = {
    paramName: "images",
    maxFiles: 5,
    maxFilesize: 2,
    acceptedFiles: 'image/*',
    enctype: "multipart/form-data",
    addRemoveLinks: true,
    uploadMultiple: true,
    autoProcessQueue: false,
    autoDiscovery: false,


    dictDefaultMessage: "Arraste arquivos aqui para enviar",
    dictFallbackMessage: "Seu navegador não suporta a função de arrastar arquivos",
    dictFallbackText: "Use o link acima para enviar arquivos",
    dictFileTooBig: "Arquivo muito grande ({{filesize}}MiB). Tamanho máximo: {{maxFilesize}}MiB.",
    dictInvalidFileType: "Formato do arquivo é invalido",
    dictResponseError: "Erro ao enviar arquivo",
    dictCancelUpload: "Cancelar envio",
    dictUploadCanceled: "Envio cancelado",
    dictCancelUploadConfirmation: "Tem certeza que deseja cancelar o envio?",
    dictRemoveFile: "Remover arquivo",
    dictRemoveFileConfirmation: null,
    dictMaxFilesExceeded: "Limite máximo de arquivos atingido"
  };

  var form = $("form#newRaffleForm");

  $("div#raffleImages").addClass('dropzone');
  raffleImages = new Dropzone("div#raffleImages", { url: form.attr('action') });  
}
}

function doChartInitialization(){
  $('.raffleProgessChart').each(function(e){
    var ctxP = this;
    var myPieChart = new Chart(ctxP, {
      type: 'doughnut',
      data: {
        labels: ["Vendidos", "Em Aberto"],
        datasets: [{
          data: [this.getAttribute('data-tickets-sold'), this.getAttribute('data-tickets-open')],
          backgroundColor: ["#fed18c", "#fe664f"],
          hoverBackgroundColor: ["#ffa926", "#ff3112"]
        }]
      },
      options: {
        responsive: true
      }
    });  
  });
}

function doInputFormating(){
  $('.currency').mask('#.##0,00', {reverse: true});
  $('.datepicker').datepicker();
}

function doDisableFrom(){
  $("div.disabled").find("input.form-control").prop("disabled", true);
  $("div.disabled").find("textarea.form-control").prop("disabled", true);
  $("div.disabled").find("select").prop("disabled", true);
}

function doInputErrorMessages(model, errors_json) {
  $('.is-invalid').removeClass('is-invalid');
  $('.invalid-feedback').html('');

  Object.keys(errors_json).forEach(function(key) {
    if (model != '') {
      document.getElementsByName(model + '[' + key + ']')[0].className += ' is-invalid';
    }else{
      document.getElementsByName(key)[0].className += ' is-invalid';
    }
    $('#' + key + '_feedback').html(errors_json[key].join(','));
  })
}
