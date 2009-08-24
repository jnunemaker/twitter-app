class UsersController < ApplicationController
  before_filter :authenticate
  
  def show
    @tweets = current_user.client.user_timeline(:id => params[:id])
    @user = current_user.client.user(params[:id])
  end
end