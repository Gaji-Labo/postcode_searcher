#$.mockjax
#  url: "/search/*"
#  response: (settings) ->
#    postcode = _.last settings.url.split("/")
#    if /^\d{3}\-\d{4}$/.test(postcode) or /^\d{7}$/.test(postcode)
#      this.responseText = {
#        "prefecture": "東京都"
#        "city": "渋谷区"
#        "address": "千駄ヶ谷"
#      }
#    else if /^\d{3}\-\d{1,4}$/.test(postcode) or /^\d{4,7}$/.test(postcode)
#      this.responseText = [
#        {
#          "postcode": "1510051"
#          "prefecture": "東京都"
#          "city": "渋谷区"
#          "address": "千駄ヶ谷"
#        }
#        , {
#          "postcode": "1510051"
#          "prefecture": "東京都"
#          "city": "渋谷区"
#          "address": "千駄ヶ谷"
#        }
#        , {
#          "postcode": "1510051"
#          "prefecture": "東京都"
#          "city": "渋谷区"
#          "address": "千駄ヶ谷"
#        }
#      ]
#    else
#      this.responseText = { "message": "not found."}
