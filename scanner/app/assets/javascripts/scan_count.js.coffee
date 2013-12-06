# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	request_count()
	setInterval (->
		request_count()
	), 15000

request_count = ->
	$.ajax
		type: "GET"
		url: "/scan_count.json"
		success: update_counter
	return

update_counter = (results) ->
	location = $("#scan_counter")
	location.empty()
	location.append "<a>#{ results.count } Hosts Scanned</a>"
