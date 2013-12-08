$(document).ready(function() {
  //toggle show/hide for favorites
  $('#favsbutton').click(showHideFavs);
  
  $(document).on('ajax:success', '#search_results', function(e, data, status, xhr){
    $('#feedlist').html(xhr.responseText);
  });
});

var toggleFavorited = function() {
  var listingID = $(this).attr('id').split('-')[2];
  updateStar(listingID);
  reloadFavorites(listingID);
};

var reloadFavorites = function(listingID) {
  $.ajax({
    url: "favorites",
    data: "&listing_id=" + listingID,
    async: false,
    success: function(result) { $('#favslist').html(result); }
  });
};

var reloadListings = function() {
  $.ajax({
    url: "search_results",
    async: false,
    success: function(result) { $('#feedlist').html(result); }
  });
};

var showListing = function() {
  var listingID = $(this).parent().attr('id').split('-')[1];
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

var updateStar = function(listingID) {
  $('.listing-'+listingID).toggleClass('fa-star fa-star-o');
};

var showHideFavs = function() {
  if ($('#favslist').is(":visible")) {
    $('#favslist').slideUp();
    $(this).text('show');
  } else {
    $('#favslist').slideDown();
    $(this).text('hide');
  }
};
