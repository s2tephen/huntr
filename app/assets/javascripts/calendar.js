$(document).ready(function() {  
  // prev/next month buttons for calendar
  $('#prev-month').bind('ajax:success', renderCal);
  $('#next-month').bind('ajax:success', renderCal);
  $('.listing-details').click(showListing);
});

var renderCal = function(e, data, status, xhr) {
  $('#calendar').html(xhr.responseText);
};