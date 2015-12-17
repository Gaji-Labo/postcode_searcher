class PostcodeController < ApplicationController

  def index
  end

  def search
    postcode = Postcode.search(params[:postcode])
    render json: postcode.to_json
  end
end
