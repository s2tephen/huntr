$(document).ready(function() {
  //show calendar
  $('#view-cal').click(function(){
    $('#listing').removeClass('listing-show').addClass('make_transist').addClass('listing-hide');
    $('#calendar').show();
  });
});