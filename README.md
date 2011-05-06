TwitterApp
==========
TwitterApp is a very basic Rails 3 application that demonstrates how to use the
[Sign in with Twitter](http://dev.twitter.com/pages/sign_in_with_twitter)
workflow with version 1.x of the [twitter
gem](https://github.com/jnunemaker/twitter/) (which has removed built-in OAuth
support).

Installation
------------
    git clone git://github.com/jnunemaker/twitter-app.git
    cd twitter-app
    bundle install

Usage
-----
Using TwitterApp requires you to [register an app with
Twitter](http://dev.twitter.com/apps) to obtain OAuth credentials. Once you
obtain credentials, substitute your consumer key and secret into the command
below.

    CONSUMER_KEY=abc CONSUMER_SECRET=123 rails server

OmniAuth
--------
There is an [omniauth
branch](https://github.com/jnunemaker/twitter-app/tree/omniauth) that
demonstrates integration with the [omniauth
gem](https://github.com/intridea/omniauth) instead of the [oauth
gem](https://github.com/oauth/oauth-ruby).
