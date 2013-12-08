$(document).ready(function() {
  //show calendar
  $('#view-cal').click(function(){
    $('#listing').removeClass('listing-show').addClass('make_transist').addClass('listing-hide');
    $('#calendar').show();
  });
  
  // prev/next month buttons for calendar
  $('#prev-month').bind('ajax:success', renderCal);
  $('#next-month').bind('ajax:success', renderCal);
  $('.listing-details').click(showListing);
});

var renderCal = function(e, data, status, xhr) {
  $('#calendar').html(xhr.responseText);
};