$(function(){
  $('.search-bar-options input').change(function(){
    $('.search-bar-options-modal-toggle').html("");
    $(".search-bar-options input[type='checkbox']:checked").each(function(i, option){
      $('.search-bar-options-modal-toggle').append('<span class="place-option">'+ $(option).parent().text() +'</span>')
    });
  })
});
