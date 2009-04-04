# == Schema Information
# Schema version: 20090404062822
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  email              :string(255)
#  encrypted_password :string(128)
#  salt               :string(128)
#  token              :string(128)
#  token_expires_at   :datetime
#  email_confirmed    :boolean(1)      not null
#  atoken             :string(255)
#  asecret            :string(255)
#

class User < ActiveRecord::Base
  include Clearance::App::Models::User
  
  attr_accessible :atoken, :asecret
  
  def authorized?
    !atoken.blank? && !asecret.blank?
  end
  
  def oauth
    @oauth ||= Twitter::OAuth.new(ConsumerConfig['token'], ConsumerConfig['secret'])
  end
  
  def client
    @client ||= begin
      oauth.authorize_from_access(atoken, asecret)
      Twitter::Base.new(oauth)
    end
  end
end
