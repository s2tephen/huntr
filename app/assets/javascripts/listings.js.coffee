# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

(function() {

	$('#feedbutton').click(function(){
		if ($(this).hasClass('feedall')){
			$(this).removeClass('feedall');
			$(this).text('view all');
		} else {
			$(this).addClass('feedall');
			$(this).text('view archive');
		}
	});

	$('#subsbutton').click(function(){
		if ($(this).hasClass('showsubs')) {
			$('#subslist').slideUp();
			$(this).removeClass('showsubs');
			$(this).text('show');
		} else {
			$('#subslist').slideDown();
			$(this).addClass('showsubs');
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

})();
