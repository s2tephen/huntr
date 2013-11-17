//Primary Author: Yinfu

$(document).ready((function() {

	//initialize listing detail view to be hidden
	$('#listingdetail').slideUp();
	$('#listingdetail').removeClass('listingview');

	//toggle archive/all for feed
	$('#feedbutton').click(function(){
		if ($(this).hasClass('feedall')){
			$(this).removeClass('feedall');
			$(this).text('view all');
			$.ajax({
				url: 'display_archive',
				success: function(result){
					$('#feedlist').html(result);
				}
			});
		} else {
			$(this).addClass('feedall');
			$(this).text('view archive');
			$.ajax({
				url: 'display_all',
				success: function(result){
					$('#feedlist').html(result);
				}
			});
		}
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
	$('.listingarea').click(function(){
		//insert ajax to do following line
		//@listing = Listing.find_by_name($(this.children('#listingname').text()))
		$('#calendar').slideUp();
		$('#calendar').removeClass('calendarview');
		$('#listingdetail').slideDown();
		$('#listingdetail').addClass('listingview');
	});

}));
