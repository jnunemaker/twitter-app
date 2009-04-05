require 'test_helper'

class StatusesHelperTest < ActionView::TestCase
  context "linkup_replies" do
    should "linkup replies at beginning of text" do
      linkup_mentions("@jnunemaker you suck!").should == '@<a href="/users/jnunemaker">jnunemaker</a> you suck!'
      linkup_mentions("@jnunemaker: you suck!").should == '@<a href="/users/jnunemaker">jnunemaker</a>: you suck!'
    end
    
    should "linkup replies at the end of text" do
      linkup_mentions("word @jnunemaker").should == 'word @<a href="/users/jnunemaker">jnunemaker</a>'
    end
    
    should "linkup replies in the middle" do
      linkup_mentions("holla @jnunemaker you suck!").should == 'holla @<a href="/users/jnunemaker">jnunemaker</a> you suck!'
    end
    
    should "linkup multiple replies" do
      linkup_mentions("@THE_REAL_SHAQ you should holla @jnunemaker").should == '@<a href="/users/THE_REAL_SHAQ">THE_REAL_SHAQ</a> you should holla @<a href="/users/jnunemaker">jnunemaker</a>'
    end
  end
end
