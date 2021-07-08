require 'rails_helper'

RSpec.describe "UserSearches", type: :request do
 let(:user) {user = create(:user)}
  before do
    # simulamos para poder entrar a login    
    user = User.create(email: 'test@test.com', password: "password", password_confirmation: "password")
    # iniciamos session
    sign_in user
    # se usara para otro tipo de pruevas
    # Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
  end

  context "GET /user_searches" do
    context "when the user searches a returns a repository" do
      let(:params) do
        { query: 'TauroAlde'}
      end

      it "renders status 200" do
        VCR.use_cassette "status_200" do
          get user_searches_path params: params
          expect(response).to have_http_status(200)
        end
      end
      it "renders template index" do
        VCR.use_cassette "status_200" do
          get user_searches_path params: params
          expect(response).to render_template(:index)
        end
      end
      it "renders title template" do
        VCR.use_cassette "status_200" do
          get user_searches_path params: params
          expect(response.body).to match(/List Repositories/)
        end
      end
      it "renders Name repo" do
        VCR.use_cassette "status_200" do
          get user_searches_path params: params
          expect(response.body).to match(/node-clima-cli/)
        end
      end
      it "renders username" do
        VCR.use_cassette "status_200" do
          get user_searches_path params: params
          expect(response.body).to match(/TauroAlde/)
        end
      end
      it "renders created at" do
        VCR.use_cassette "status_200" do
          get user_searches_path params: params
          expect(response.body).to match(/2021-05-20/)
        end
      end
    end

    context "when the user searches a repository that returns not found response" do 
      let(:params) do
        { query: 'asd'}
      end
      it "renders title template" do
        VCR.use_cassette "status_404" do
          get(user_searches_path, params: params)
          expect(response.body).to match(/Serach user from github/)
        end
      end
      it "renders not found error messenge" do
        VCR.use_cassette "status_404" do
          get(user_searches_path, params: params)
          expect(response.body).to match(/The listed users and repositories cannot be searched either because the res/)
        end
      end
      it "renders template not found" do
        VCR.use_cassette "status_404" do
          get(user_searches_path, params: params)
          expect(response).to render_template(:not_found)
        end
      end
    end
  end

  context "POST /user_searches" do
    context "When the user select the starred" do
      let(:params) do
        { query: 'TauroAlde', repository: 'node-clima-cli', id: 1 }
      end
      it "renders /user_searches" do
        VCR.use_cassette "status_302_post" do
          post user_searches_path, params: params
          expect(response).to redirect_to(user_searches_path(query: params[:query]))
        end
      end
    end
  end

  context "UPDATE /user_searches" do
    context "When the user select the starred" do
      let(:params) do
        { query: 'TauroAlde', repository: 'node-clima-cli' }
      end
      it "renders /user_searches/id" do
        VCR.use_cassette "status_200_update" do
          patch "/user_searches/#{user.id}", params: params
          expect(response).to redirect_to(user_searches_path(query: params[:query]))
        end
      end
    end
  end
end