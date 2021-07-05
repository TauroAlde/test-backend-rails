require 'rails_helper'

RSpec.describe "UserSearches", type: :request do

  before do
    create(:user, uid: OmniAuth.config.mock_auth[:github]["uid"])
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  describe "GET /user_searches" do
    it "works! (now write some real specs)" do
      get user_searches_path
      expect(response).to have_http_status(200)
    end
  end
end
""