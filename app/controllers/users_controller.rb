class UsersController < ApplicationController
  before_filter :authenticate

  def show
    @tweets = client.user_timeline(:id => params[:id])
    @user = client.user(params[:id])
  end
end