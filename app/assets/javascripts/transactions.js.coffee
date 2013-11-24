jQuery ->
  Stripe.setPublishableKey($('#public_key').val())
  $('input[type=submit]').attr('disabled', false)
  $(".new-card").removeClass("hide") if $("#update_card").is(":checked")
  transaction.setupForm()

transaction =
  setupForm: ->
    $('.card-form').submit ->
      if $("#update_card").length and not $("#update_card").is(":checked")
        true
      else
        $('input[type=submit]').attr('disabled', true)
        if $('#card_number').length
          $(this).addClass("current_form")
          transaction.processCard()
          false
        else
          true
    $("#update_card").click ->
      if $(this).is(":checked")
        $(".new-card").removeClass("hide")
      else
        $(".new-card").addClass("hide")

    $("#transaction_quantity").keyup (e)->
      value = $(this).val();
      $(this).val(value.slice(0,-1)) if isNaN(value)
      qty = parseInt($(this).val())
      qty = 1 if qty < 1
      price = $(this).closest("form").find("#item_price").val()
      unless isNaN(qty)
        $(this).val(qty.toString())
        price = qty*parseFloat(price)
      $(this).closest("form").find(".total-price").html("$#{price}")

  processCard: ->
    card =
      number: $('.current_form #card_number').val()
      cvc: $('.current_form #card_code').val()
      expMonth: $('.current_form #card_month').val()
      expYear: $('.current_form #card_year').val()
    Stripe.createToken(card, transaction.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('.current_form #stripe_card_token').val(response.id)
      $(".current_form")[0].submit()
    else
      $(".current_form .stripe_error").text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
      $(".current_form").removeClass("current_form")