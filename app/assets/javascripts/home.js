$(document).ready(function() {
  // Show/hide favorites button
  $('#favsbutton').click(showHideFavs);
  
  // AJAX call for search results
  $(document).on('ajax:success', '#search_results', function(e, data, status, xhr){
    $('#feedlist').html(xhr.responseText);
  });
});

// Toggles a favorited listing's star, refreshes the favorites summary
var toggleFavorited = function() {
  var listingID = $(this).attr('id').split('-')[2];
  updateStar(listingID);
  reloadFavorites(listingID);
};

// Reloads the favorites summary
var reloadFavorites = function(listingID) {
  $.ajax({
    url: "favorites",
    data: "&listing_id=" + listingID,
    async: false,
    success: function(result) { $('#favslist').html(result); }
  });
};

// Reloads the listings summary
var reloadListings = function() {
  $.ajax({
    url: "search_results",
    async: false,
    success: function(result) { $('#feedlist').html(result); }
  });
};

// Displays a single listing in the right pane
var showListing = function() {
  var listingID = $(this).attr('id').split('-')[1];
  $('#listing').removeClass('listing-show').addClass('make_transist listing-hide');
  $('#listing-'+listingID).removeClass('listing-unread');
  setTimeout(function() {
    $.get( 'listings/' + listingID, function(data) {
      $('#listing').html(data);
      makeMap("32-124");
      $('#listing').removeClass('listing-hide').addClass('listing-show');
      $('#calendar').hide();
    });
  }, 300);
};

// Toggles the color of all the favorite buttons for a listing
var updateStar = function(listingID) {
  $('.listing-'+listingID).toggleClass('fa-star fa-star-o');
  $('#calendar #listing-'+listingID).toggleClass('favorited');
};

// Show/hide the favorites summary
var showHideFavs = function() {
  if ($('#favslist').is(":visible")) {
    $('#favslist').slideUp();
    $(this).text('show');
  } else {
    $('#favslist').slideDown();
    $(this).text('hide');
  }
};
