class SessionsController < ApplicationController
  def new
    @user = client.user if signed_in?
  end

  def create
    request_token = oauth_consumer.get_request_token(:oauth_callback => callback_url)
    session['request_token'] = request_token.token
    session['request_secret'] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  def callback
    request_token = OAuth::RequestToken.new(oauth_consumer, session['request_token'], session['request_secret'])
    access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    reset_session
    session['access_token'] = access_token.token
    session['access_secret'] = access_token.secret
    user = client.verify_credentials
    sign_in(user)
    redirect_back_or root_path
  end
end
