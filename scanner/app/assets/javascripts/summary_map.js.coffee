$ ->
	initialize_summary_map()

initialize_summary_map = ->
	if $("#summary_canvas").length
		#AJAX request.
		#Set mapOptions
		#Create Map opject
		#Iterate through locations
		#Create Markers
		location = new google.maps.LatLng(29.228890, 11.898193)

		mapOptions = 
			zoom: 1
			center: location

		map = new google.maps.Map(document.getElementById("summary_canvas"), mapOptions)

		# AJAX, create markers.
	else
		return
