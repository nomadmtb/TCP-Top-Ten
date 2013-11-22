# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	request_count()

request_count = ->
	$.ajax
		type: "GET"
		url: "http://172.16.12.188:3000/scan_count.json"
		success: update_counter
	return

update_counter = (results) ->
	location = $("#scan_counter")
	location.empty()
	location.append "<a>#{ results.count } Hosts Scanned</a>"
