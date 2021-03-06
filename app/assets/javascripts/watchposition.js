jQuery(window).ready(function(){
            gMapInit();
            jQuery("#watchPositionBtn").click(initiate_watchlocation);
            jQuery("#stopWatchBtn").click(stop_watchlocation);
        });
        function gMapInit(){
          var google_tile = "http://maps.google.com/maps/api/staticmap?sensor=false&center=-34.397,150.644&zoom=8&size=300x400"
          jQuery("#googleMap").html(
              jQuery(document.createElement("img")).attr("src", google_tile)
          );
        }
        var watchProcess = null;
 
        function initiate_watchlocation() {
          if (watchProcess == null) {
              watchProcess = navigator.geolocation.watchPosition(handle_geolocation_query, handle_errors);
          }
        }
 
        function stop_watchlocation() {
          if (watchProcess != null)
          {
              navigator.geolocation.clearWatch(watchProcess);
              watchProcess = null;
          }
        }
 
        function handle_errors(error)
        {
            switch(error.code)
            {
                case error.PERMISSION_DENIED: alert("user did not share geolocation data");
                break;
 
                case error.POSITION_UNAVAILABLE: alert("could not detect current position");
                break;
 
                case error.TIMEOUT: alert("retrieving position timedout");
                break;
 
                default: alert("unknown error");
                break;
            }
        }
 
        function handle_geolocation_query(position) {
          var text = "position.coords.latitude: "  + position.coords.latitude  + "<br/>" +
                     "position.coords.longitude: " + position.coords.longitude + "<br/>" +
                     "position.coords.altitude: " + position.coords.altitude + "<br/>" +
                     "position.coords.accuracy(meters): "  + position.coords.accuracy  + "<br/>" +
                     "position.coords.altitudeAccuracy(meters): "  + position.coords.altitudeAccuracy  + "<br/>" +
                      "position.coords.heading: "  + position.coords.heading  + "<br/>" +
                      "position.coords.speed: "  + position.coords.speed  + "<br/>" +
                     "position.timestamp: " + new Date(position.timestamp);
          jQuery("#APIReturnValues").html(text);
          jQuery("#APIReturnValues").css("border","1px solid green");
 
          var image_url = "http://maps.google.com/maps/api/staticmap?sensor=false&center=" + position.coords.latitude + ',' + position.coords.longitude +
                          "&zoom=14&size=300x400&markers=color:blue|label:S|" + position.coords.latitude + ',' + position.coords.longitude;
          
          jQuery("#googleMap").html(
              jQuery(document.createElement("img")).attr("src", image_url)
          );
        }