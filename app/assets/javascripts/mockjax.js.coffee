$.mockjax
  url: "/search/*"
  response: (settings) ->
    postcode = _.last settings.url.split("/")
    if /\d/.test(postcode)
      this.responseText = {
        "prefecture": "東京都"
        "city": "渋谷区"
        "address": "千駄ヶ谷"
      }
    else
      this.responseText = { "message": "not found."}
