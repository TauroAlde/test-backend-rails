require 'rails_helper'

RSpec.describe "UserSearches", type: :request do

  before do
    # simulamos para poder entrar a login
    user = create(:user)
    user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password")
    # iniciamos session
    sign_in user
    # se usara para otro tipo de pruevas
    # Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  describe "GET /user_searches" do
    it "spec join route user_seaches_path with status 200" do
      VCR.use_cassette "status_200" do
        get user_searches_path
        expect(response).to have_http_status(200)
      end
    end
  end
end