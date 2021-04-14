class UserSearchesController < ApplicationController
  before_action :authenticate_user!

  require 'net/http'
  require 'uri'
  require 'rubygems'
  require 'bundler/setup'
  require 'json'

  def index

    uri = URI.parse("https://api.github.com/search/repositories?q=user:#{params[:query]}&sort=updated")

    request = Net::HTTP::Get.new(uri)
    request.basic_auth(Rails.application.credentials.username_github, Rails.application.credentials.authorization_github)

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    
    @repositories = ActiveSupport::JSON.decode(response.body)

  end

  def create

    uri_check = URI.parse("https://api.github.com/user/starred/#{params[:query]}/#{params[:repository]}?access_token=#{Rails.application.credentials.access_token}")

    request = Net::HTTP::Get.new(uri_check)

    req_options = {
      use_ssl: uri_check.scheme == "https",
    }

    response = Net::HTTP.start(uri_check.hostname, uri_check.port, req_options) do |http|
      http.request(request)
    end

    
    def client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = "#{Rails.application.credentials.twitter_consumer_key}"
        config.consumer_secret     = "#{Rails.application.credentials.twitter_consumer_secret}"
        config.access_token        = "#{Rails.application.credentials.twitter_access_token}"
        config.access_token_secret = "#{Rails.application.credentials.twitter_access_token_secret}"
      end
    end

    if response.code == '404'

      client.update("user github: #{current_user.nickname}"+" add star to repository: #{params[:repository]}")

      uri_star = URI.parse("https://api.github.com/user/starred/#{params[:query]}/#{params[:repository]}?access_token=#{Rails.application.credentials.access_token}")

      request = Net::HTTP::Put.new(uri_star)

      req_options = {
        use_ssl: uri_star.scheme == "https",
      }

      response = Net::HTTP.start(uri_star.hostname, uri_star.port, req_options) do |http|
        http.request(request)
      end

    end

    @repository = Repository.find_or_create_by(repo_id: params[:repo_id], user_id: current_user.id)

    if !@repository.new_record?
      @repository.update(star: true)
      redirect_to user_searches_path(query: params[:query])
    else
      render :index, :alert => 'Already unstar'
    end

  end

  def update

    uri_check = URI.parse("https://api.github.com/user/starred/#{params[:query]}/#{params[:repository]}?access_token=#{Rails.application.credentials.access_token}")
    request = Net::HTTP::Get.new(uri_check)
    
    req_options = {
      use_ssl: uri_check.scheme == "https",
    }
    
    response_check = Net::HTTP.start(uri_check.hostname, uri_check.port, req_options) do |http|
      http.request(request)
    end
    
    if response_check.code == '204'
      
      uri_unstar = URI.parse("https://api.github.com/user/starred/#{params[:query]}/#{params[:repository]}?access_token=#{Rails.application.credentials.access_token}")
      
      request_unstar = Net::HTTP::Delete.new(uri_unstar)
      
      req_options = { 
        use_ssl: uri_unstar.scheme == "https",
      }
      
      response_unstar = Net::HTTP.start(uri_unstar.hostname, uri_unstar.port, req_options) do |http|
        http.request(request_unstar)
      end
    end
    
    
    @repository = Repository.where( user_id: current_user.id, repo_id: params[:repo_id], star: true )

    if @repository.update(star: false)
      redirect_to user_searches_path(query: params[:query])
    else
      render :index, :alert => 'Already unstar'
    end
  end

  private
    def repository_params
      params.require(:repository).permit(:repo_id)
    end
end
