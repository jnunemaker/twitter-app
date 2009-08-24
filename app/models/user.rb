# == Schema Information
#
# Table name: users
#
#  id          :integer(4)      not null, primary key
#  email       :string(255)
#  atoken      :string(255)
#  asecret     :string(255)
#  screen_name :string(30)
#

class User < ActiveRecord::Base
  attr_accessible :atoken, :asecret
  
  def authorized?
    atoken.present? && asecret.present?
  end
  
  def oauth
    @oauth ||= Twitter::OAuth.new(ConsumerConfig['token'], ConsumerConfig['secret'])
  end
  
  delegate :request_token, :access_token, :authorize_from_request, :to => :oauth
  
  def client
    @client ||= begin
      oauth.authorize_from_access(atoken, asecret)
      Twitter::Base.new(oauth)
    end
  end
end
