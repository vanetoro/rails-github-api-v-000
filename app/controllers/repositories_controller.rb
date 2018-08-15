class RepositoriesController < ApplicationController
  def index
  response = Faraday.get("https://api.github.com/user?access_token=#{session[:token]}")
  body = JSON.parse(response.body)
  repos = Faraday.get("#{body['repos_url']}")
  @repoList = JSON.parse(repos.body)
  end

  def create
    # binding.pry
    repo = Faraday.post("https://api.github.com/#{params[:user]}/repos") do |req|
      req.body = {
        "authorization": session[:token],
        "name": params[:name],
        "private": false
      }
    end
    binding.pry
    redirect_to root_path
  end
end
