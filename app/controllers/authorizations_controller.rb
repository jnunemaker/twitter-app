class AuthorizationsController < ApplicationController
  def new    
    current_user.oauth.set_callback_url(authorization_url)
    
    session['rtoken'] = current_user.request_token.token
    session['rsecret'] = current_user.request_token.secret
    
    redirect_to current_user.request_token.authorize_url
  end
  
  def show
    current_user.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])
    
    session['rtoken'] = nil
    session['rsecret'] = nil
    
    current_user.update_attributes({
      :atoken => current_user.access_token.token, 
      :asecret => current_user.access_token.secret,
    })
    
    redirect_to root_path
  end
end
