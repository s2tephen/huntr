$(document).ready(function() {
  $('.list-star').click(toggleFavorited);
});

var makeMap = function(location) {
  $.ajax({
    url: "http://whereis.mit.edu/search/",
    type: "GET",
    data: {type: 'query', q: location, output: 'json'},
    dataType: 'jsonp'
  })
  .done(function(mapData){
    mapData = mapData[0];
    var eventLocation = new google.maps.LatLng(mapData.lat_wgs84, mapData.long_wgs84);
    var mapOptions = {
      zoom: 15,
      center: eventLocation,
      mapTypeControl: false
    };
    
    var map = new google.maps.Map(document.getElementById("location-map"), mapOptions);
    
    var mapMarker = new google.maps.Marker({
      position: eventLocation,
      map: map,
      title: location
    });
  });
};
