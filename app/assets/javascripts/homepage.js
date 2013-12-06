$(document).ready(function() {
  // Initialize listing detail view to be hidden
  $('#listingdetail').slideUp();
  $('#listingdetail').removeClass('listingview');
  
  //toggle show/hide for favorites
  $('#favsbutton').click(function(){
    if ($(this).hasClass('showfavs')) {
      $('#favslist').slideUp();
      $(this).removeClass('showfavs');
      $(this).text('show');
    } else {
      $('#favslist').slideDown();
      $(this).addClass('showfavs');
      $(this).text('hide');
    }
  });

  //show calendar
  $('#view-cal').click(function(){
    $('#listing').fadeOut(650, $('#calendar').fadeIn(650));
  });

  //show listing detail
  $('.listing-area').click(function(){
    //insert ajax to do following line
    var listing_id = $(this).attr('id').split('-')[1];
    $('#listing').removeClass('listing-show').addClass('make_transist').addClass('listing-hide');
    $('#listing-'+listing_id).removeClass('listing-unread');
    setTimeout(function() {
      $.get( 'listings/' + listing_id, function(data) {
        makeMap("32-124");
        $('#listing').html(data);
        $('#listing').removeClass('listing-hide').addClass('listing-show');
      });
    }, 300);
  });
  
  // favorite/unfavorite listing
  $('.fav-button').click(function(){
    var listing_id = $(this).attr('id').split('-')[2];
    var add_fav = $(this).hasClass('fa-star-o');
    $(this).toggleClass('fa-star-o fa-star');
    $.ajax({
      url: "fav_listing",
      data: "add_fav="+ add_fav + "&listing_id=" + listing_id,
      success: function(result) {
        $('#favslist').html(result);
      }
    });
    $('.fav-button').unbind();
  });

  $(document).on('ajax:success', '#search_results', function(e, data, status, xhr){
    $('#feedlist').html(xhr.responseText);
  });
});