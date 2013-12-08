$(document).ready(function() {  
  // Previous/next month arrows for calendar
  $('#prev-month').bind('ajax:success', renderCal);
  $('#next-month').bind('ajax:success', renderCal);
  // Attach click listener to each event listing
  $('.listing-bullet').click(showListing);
});

// Re-renders calendar
var renderCal = function(e, data, status, xhr) {
  $('#calendar').html(xhr.responseText);
};