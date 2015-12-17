$ ->
  PostcodeView = Backbone.View.extend
    el: 'body'

    events:
      "keyup #postcode": "onKeyUp"

    onKeyUp: ->
      postcode = $("#postcode").val()
      if postcode.length > 3
        $.getJSON "/search/#{postcode}", (data) ->
          $address = $(".address")
          if data
            if data.message
              $address.html data.message
            else
              if data instanceof Array
                $address.empty()
                _.each data, (d) =>
                  $address.append """
                    #{d.postcode}
                    #{d.prefecture}
                    #{d.city}
                    #{d.address}<br />
                  """
              else
                $address.html """
                  #{data.prefecture}
                  #{data.city}
                  #{data.address}
                """

  new PostcodeView()
