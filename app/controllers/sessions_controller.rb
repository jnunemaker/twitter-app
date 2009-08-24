class SessionsController < ApplicationController  
  def new
  end
  
  def create
    oauth = Twitter::OAuth.new(ConsumerConfig['token'], ConsumerConfig['secret'], :sign_in => true)
    oauth.set_callback_url(finalize_session_url)
    
    session['rtoken'] = oauth.request_token.token
    session['rsecret'] = oauth.request_token.secret
    
    redirect_to oauth.request_token.authorize_url
  end
  
  def destroy
    reset_session
    redirect_to new_session_path
  end
  
  def finalize
    oauth = Twitter::OAuth.new(ConsumerConfig['token'], ConsumerConfig['secret'], :sign_in => true)
    oauth.authorize_from_request(session['rtoken'], session['rsecret'], params[:oauth_verifier])
    
    session['rtoken'] = nil
    session['rsecret'] = nil
    
    tweep = Twitter::Base.new(oauth).verify_credentials
    logger.info "\n\n" + tweep.inspect + "\n\n"
    
    user = User.find_or_create_by_screen_name(tweep.screen_name)
    
    user.update_attributes({
      :atoken => oauth.access_token.token, 
      :asecret => oauth.access_token.secret,
    })
    
    sign_in(user)
    redirect_to root_path
  end
end
