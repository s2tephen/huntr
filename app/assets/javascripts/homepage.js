//Primary Author: Yinfu

$(document).ready((function() {

	//initialize listing detail view to be hidden
	$('#listingdetail').slideUp();
	$('#listingdetail').removeClass('listingview');

	//toggle archive/all for feed
	$('#archivebutton').click(function(){
		console.log("archivebutton clicked");
		$(this).hide();
		$('#feedbutton').show();
		$.ajax({
			url: 'display_archive',
			success: function(result){
				$('#feedlist').html(result);
			}
		});
		$('#feedbutton').unbind();
	});
	
	$('#feedbutton').click(function(){
		console.log("feedbutton clicked");
		$(this).hide();
		$('#archivebutton').show();
		$.ajax({
			url: 'display_all',
			success: function(result){
				$('#feedlist').html(result);
			}
		});
		$('#archivebutton').unbind();
	});
	
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
	$('#viewcal').click(function(){
		$('#listingdetail').slideUp();
		$('#listingdetail').removeClass('listingview');
		$('#calendar').slideDown();
		$('#calendar').addClass('calendarview');
	});

	//show listing detail
	$('.listing-area').click(function(){
		//insert ajax to do following line
		//@listing = Listing.find_by_name($(this.children('#listingname').text()))
		var listing_id = $(this).attr('id').split("-")[1];
		//$('#calendar').slideUp();
		$('#calendar').removeClass('calendarview');
		//$('#listingdetail').slideDown();
		$('#listingdetail').addClass('listingview');
		$('#calendar').load("listings/" + listing_id);
	});
	
	// execute search
	// $('#search_results').submit(function() {
	  // console.log("HELLO")
	  // $.ajax({
      // url: 'search_results',
      // complete: function(result){
        // $('#feedlist').html(result);
      // }
    // });
	// });
  $(document).on("ajax:success", '#search_results', function(e, data, status, xhr){
    $('#feedlist').html(xhr.responseText);
  });
	
	 // execute search
  // $('#search_results').submit(function() {  
      // $.ajax({
          // url: $(this).attr('action'), //sumbits it to the given url of the form
      // }).success(function(json){
          // //act on result.
      // });
      // return false; // prevents normal behaviour
  // });
}));
