module TwitterStubs
  def fixture(name)
    File.new("#{Rails.root}/spec/fixtures/#{name}.json")
  end
  
  def stub_oauth_request_token!
    stub_request(:post, "http://api.twitter.com/oauth/request_token").to_return(:body => "oauth_token=t&oauth_token_secret=s")
  end
  
  def stub_oauth_access_token!
    stub_request(:post, "http://api.twitter.com/oauth/access_token").to_return(:body => "oauth_token=at&oauth_token_secret=as")
  end
  
  def stub_verify_credentials!
    stub_request(:get, "https://api.twitter.com/1/account/verify_credentials.json").to_return(:body => fixture("verify_credentials"))
  end
end
