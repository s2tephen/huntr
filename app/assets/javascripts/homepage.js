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
		$('#listing').slideUp();
		$('#calendar').slideDown();
	});

	//show listing detail
	$('.listing-area').click(function(){
		//insert ajax to do following line
		var listing_id = $(this).attr('id').split("-")[1];
		$('#calendar').slideUp();
		$('#listing').load("listings/" + listing_id).slideDown();
	});

  $(document).on("ajax:success", '#search_results', function(e, data, status, xhr){
    $('#feedlist').html(xhr.responseText);
  });
}));
