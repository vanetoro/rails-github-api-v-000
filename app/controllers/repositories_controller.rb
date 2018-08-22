class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
  response = Faraday.get("https://api.github.com/user?access_token=#{session[:token]}")
  body = JSON.parse(response.body)
  binding.pry
  repos = Faraday.get("#{body['repos_url']}")

  @repoList = JSON.parse(repos.body)
  end

  def create
    # repo = Faraday.post("https://api.github.com/user/repos") do |req|
    #   req.body = {
    #     "name": "#{params[:name]}",
    #     'description': 'Test repo',
    #     "private": false
    #   }
    #   req.headers['Accept'] = 'application/json'
    #   req.headers['Authorization'] = "token #{session[:token]}"
    # end

    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    # redirect_to '/'
    redirect_to root_path
  end
end
