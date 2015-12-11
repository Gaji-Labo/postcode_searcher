$ ->
  view = Backbone.View.extend
    el: 'body'

    events:
      "click .submit": "onSubmit"

    onSubmit: ->
      postcode = $("#postcode").val()
      if postcode.length > 0
        $.getJSON "/search/#{postcode}", (data) ->
          if data.message
            $(".address").html data.message
          else
            $(".address").html """
              #{data.prefecture}
              #{data.city}
              #{data.address}
            """

  new view()
