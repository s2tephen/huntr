$(document).ready(function() {
  // Favorite button
  $('.list-star').click(toggleFavorited);
  
  // Shows calendar, hides listing
  $('#view-cal').click(function(){
    $('#listing').removeClass('listing-show').addClass('make_transist').addClass('listing-hide');
    $('#calendar').show();
  });
});

// Creates a Google Map for the event's location
var makeMap = function() {
  var mapDiv = document.getElementById("location-map");
  if (mapDiv != null) { // Map div exists
    var location = mapDiv.getAttribute("data-loc");
    if (location.length > 0) {
      $.ajax({
        url: "http://whereis.mit.edu/search/",
        type: "GET",
        data: {type: 'query', q: location, output: 'json'},
        dataType: 'jsonp'
      })
      .done(function(mapData){
        if (mapData.length > 0) {
          mapData = mapData[0];
          var eventLocation = new google.maps.LatLng(mapData.lat_wgs84, mapData.long_wgs84);
          var mapOptions = {
            zoom: 15,
            center: eventLocation,
            mapTypeControl: false
          };
          
          var map = new google.maps.Map(mapDiv, mapOptions);
          
          var mapMarker = new google.maps.Marker({
            position: eventLocation,
            map: map,
            title: location
          });
        }
        else { showNoMap(); }
      });
    }
    else { showNoMap(); }
  }
};

var showNoMap = function() {
  $('#location-map').html("No map available for this location");
};
