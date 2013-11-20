jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  $('input[type=submit]').attr('disabled', false)
  transaction.setupForm()

transaction =
  setupForm: ->
    $('.card-form').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        $(this).addClass("current_form")
        transaction.processCard()
        false
      else
        true
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, transaction.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#stripe_card_token').val(response.id)
      $(".current_form")[0].submit()
    else
      $(".current_form .stripe_error").text(response.error.message)
      $('input[type=submit]').attr('disabled', false)
      $(".current_form").removeClass("current_form")