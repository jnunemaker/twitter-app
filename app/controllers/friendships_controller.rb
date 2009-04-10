class FriendshipsController < ApplicationController
  before_filter :authenticate
  
  def create
    flash[:notice] = "You are now following #{params[:user]}. It may not show below due to API latency."
    current_user.client.friendship_create(params[:user])
    return_to_or user_url(:id => params[:user])
  rescue Twitter::General
    flash[:notice] = "You are already following #{params[:user]} so nothing was done."
    return_to_or user_url(:id => params[:user])
  end
  
  def destroy
    flash[:notice] = "You are no longer following #{params[:id]}. It may show like you are below due to API latency."
    current_user.client.friendship_destroy(params[:id])
    return_to_or user_url(:id => params[:id])
  rescue Twitter::General
    flash[:notice] = "You are not following #{params[:id]} so nothing was done."
    return_to_or user_url(:id => params[:id])
  end
end
