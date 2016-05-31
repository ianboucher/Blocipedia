class UsersController < ApplicationController

  def autocomplete
    render json: User.search(params[:query], autocomplete: true, limit: 10).map do |user|
      { username: user.username, value: user.id }
    end
  end
end
