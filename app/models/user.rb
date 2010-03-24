class User
  include MongoMapper::Document

  key :screen_name, String, :required => true
  key :atoken,      String
  key :asecret,     String

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
