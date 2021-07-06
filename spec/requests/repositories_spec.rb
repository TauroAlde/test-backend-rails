require 'rails_helper'

RSpec.describe "Repositories", type: :request do

  context "user with session" do
    before do
      # simulamos para poder entrar a login
      user = create(:user)
      user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password")
      # iniciamos session
      sign_in user
    end

    it "reponds with status 200" do
      get root_path
      expect(response).to have_http_status(200)      
    end
    it "renders the index template" do
      get root_path
      expect(response).to render_template("repositories/index")
    end
    it "display title " do
      get root_path
    end
  end

  context "user with out session"do
    it "responds with status 302" do
      get root_path
      expect(response).to have_http_status(302) 
    end
    it "renders the root template" do
      get root_path
      expect(response).to redirect_to("/users/sign_in")
    end
  end
end