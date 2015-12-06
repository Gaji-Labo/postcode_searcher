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
  end

end
