$ ->
	initialize_summary_map()

initialize_summary_map = ->
	if $("#summary_canvas").length
		$.ajax
			type: "GET"
			url: "http://172.16.12.188:3000/recent_locations.json"
			success: add_markers
	else
		return

add_markers = (results) ->
	location = new google.maps.LatLng(29.228890, 11.898193)

	mapOptions = 
		zoom: 1
		center: location

	map = new google.maps.Map(document.getElementById("summary_canvas"), mapOptions)

	for result in results
		lat = result.latitude
		long = result.longitude
		location = new google.maps.LatLng(lat, long)
		marker = new google.maps.Marker
			position: location
			map: map
			optimized: false
