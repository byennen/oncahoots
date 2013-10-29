# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$('ul.posts').on 'click', '#edit-update', (event) ->
		path = $(this).data('url')
		params = {}

		$.ajax
			url: path + ".json"
			type: "GET"
			data: params
			success: (data, textStatus, jqXHR) ->
				$('#update-form #new_update div:first').append("<input name='_method' value='put' type='hidden'>")
				$('#update-form #new_update').attr("action", path)
				$('#update-form #update_headline').val(data.headline)
				$('#update-form #update_body').text(data.body)
				$('#update-form').modal()
				console.log(data.body)
			error: (jqXHR, textStatus, errorThrown) -> 
				console.log('error')