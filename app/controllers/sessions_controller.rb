class SessionsController < ApplicationController
  skip_before_action :authenticate_user
  def create
    @resp = Faraday.post("https://github.com/login/oauth/access_token" ) do |req|
      # req.body = {
      #   'client_id'=> nil,
      #   'client_secret'=> nil,
      #   'code'=> params[:code]
      # }
      # req.headers ={
      #   'Accept'=> 'application/json'
      # }

      #
      req.params['client_id'] = ENV['GITHUB_KEY']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
      req.params['state'] = params['state']
      req.headers['Accept'] = 'application/json'
    end
    binding.pry
    body = JSON.parse(@resp.body)
    session[:token] = body["access_token"]
    redirect_to '/'
  end





end
