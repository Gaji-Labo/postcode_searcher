require 'rails_helper'

RSpec.describe PostcodeController, type: :controller do

  describe "GET #search" do
    before do
      get :search, postcode: "103-0003"
    end

    it "get success" do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "get json" do
      json = JSON.parse(response.body)
      expect(json["prefecture"]).to match("東京都")
      expect(json["city"]).to match("中央区")
      expect(json["address"]).to match("日本橋横山町")
    end

    it "not found" do
      get :search, postcode: "000-0000"
      json = JSON.parse(response.body)
      expect(json["message"]).to match("not found.")
    end
  end
end
