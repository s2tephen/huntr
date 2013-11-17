//Primary Author: Yinfu

$(document).ready((function() {

	$('#feedbutton').click(function(){
		console.log("hiiii");
		if ($(this).hasClass('feedall')){
			$(this).removeClass('feedall');
			$(this).text('view all');
			$.ajax('/listings/display_archive');
		} else {
			$(this).addClass('feedall');
			$(this).text('view archive');
			$.ajax('/listings/display_all');
		}
	});

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
	$('#listingdetail').slideUp();
	$('#listingdetail').removeClass('listingview');

	/*
	//TODO: need action that swaps calendar view and listing view
	//if calendarViewAction:
	$('#listingdetail').slideUp();
	$('#listingdetail').removeClass('listingview');
	$('#calendar').slideDown();
	$('#calendar').addClass('calendarview');

	//if listingViewAction:
	$('#calendar').slideUp();
	$('#calendar').removeClass('calendarview');
	$('#listingdetail').slideDown();
	$('#listingdetail').addClass('listingview');
	*/

}));