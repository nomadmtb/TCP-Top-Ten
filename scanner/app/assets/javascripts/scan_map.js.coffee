$ ->
	initialize_map()

initialize_map = ->
	if $("#map-canvas").length
		alert 'Map Exists'
		map_div = $("#map-canvas")
		lat = map_div.attr("lat")
		long = map_div.attr("long")
		lat_long = "#{lat},#{long}"
		location = new google.maps.LatLng(lat,long)

		mapOptions =
			zoom: 6
			center: location

		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

		marker = new google.maps.Marker
			position: location
			map: map
			title: "#{lat_long}"
			optimized: false
	else
		alert 'Map MISSING'
