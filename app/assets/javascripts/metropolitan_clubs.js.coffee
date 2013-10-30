# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	commentBox = (full_name, image_url, content, created_at) ->
		box = """<li>
							<a class='avatr' href='javascript:;'><img src=#{image_url}></a>
							<h4>#{full_name}</h4>
							<p>#{content}</p>
							<a href='javascript:void(0);' class='com ncom'>#{jQuery.timeago(created_at)}</a>
							<div class='clearfix'></div>
					  </li>""";
		return box;

	# Routes
	metropolitan_club_update_path = (tag) ->
		return """/metropolitan_clubs/#{tag.data('club-id')}/updates/#{tag.data('update-id')}.json"""

	update_comment_path = (tag) ->
		return """/updates/#{tag.data('update-id')}/comments.json"""

	# Function
	showComments = (comments) ->
		for i in comments
			full_name = [i.user.first_name, i.user.last_name].join(' ')
			image_url = i.user.profile.image.small.url
			content = i.comment
			created_at = i.created_at
			comment = commentBox(full_name, image_url, content, created_at )
			$('.posts.comment').append(comment)

	showNewCommentButton = ->
		('.btn.new-comment').hide()
		$('.new_comment_box').show()

	# first load
	$.ajax
		url: metropolitan_club_update_path($('ul.listing li:first').find("h4").find("a"))
		type: "GET"
		data: {}
		success: (data, textStatus, jqXHR) ->
			$('.img-box img').attr("src", data.image.url).css({'width' : '638px' , 'height' : '400px'})
			$('.img-box').css({'background-color': '#fff'})
			$('.listing li:first').addClass("active")
			$('.posts').empty();
			showComments(data.comments)

		error: (jqXHR, textStatus, errorThrown) -> 
			$('div.img-box').css({'background-color': '#fff'})
			console.log('error')

	$('ul.listing').on 'click', '#edit-update', (event) ->
		path = metropolitan_club_update_path($(this))
		$.ajax
			url: path
			type: "GET"
			data: {}
			success: (data, textStatus, jqXHR) ->
				$('#update-form #new_update div:first').append("<input name='_method' value='put' type='hidden'>")
				$('#update-form #new_update').attr("action", path.split('.')[0])
				$('#update-form #update_headline').val(data.headline)
				$('#update-form #update_body').text(data.body)
				$('#update-form').modal()
			error: (jqXHR, textStatus, errorThrown) -> 
				console.log('error')

	$('ul.listing li').on 'click', 'p', (event) ->
		path = metropolitan_club_update_path($(this).parent().find("h4").find("a"))
		jQuery("ul.listing > li").removeClass("active")
		$(this).parent().addClass("active")

		$.ajax
			url: path
			type: "GET"
			data: {}
			success: (data, textStatus, jqXHR) ->
				$('.img-box img').attr("src", data.image.url).css({'width' : '638px' , 'height' : '400px'})
				$('.img-box').css({'background-color': '#fff'})
				$('.posts').empty();
				$('.btn.new-comment').show()
				$('.new_comment_box').hide()
				showComments(data.comments)
				console.log(data)

			error: (jqXHR, textStatus, errorThrown) -> 
				console.log('error')

	# Click on New Comment Button
	$('.btn.new-comment').on 'click', (event) ->
		$(this).hide()
		$('.new_comment_box').show()

	$(".new_comment_box .submit-comment").on 'click', (event) ->
	  $form = $(".new_comment_box").find("form")
	  $form.find('button').prop('disabled', true)
	  path = update_comment_path(jQuery("ul.listing").find("li.active").find("h4").find("a"))
	  params = $form.serializeArray()

	  $.ajax
	  	url: path
	  	type: "POST"
	  	data: params
	  	success: (data, textStatus, jqXHR) ->
	  		showComments([data])
	  		$form.find('button').prop('disabled', false)
	  		$form.find('textarea').val('')
	  	error: (jqXHR, textStatus, errorThrown) ->
	  		console.log('error')
