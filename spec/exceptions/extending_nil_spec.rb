require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module DCI::TestRole; end


describe "ExtendingNil" do
  specify do
    lambda{nil.extend DCI::TestRole}.should raise_error DCI::ExtendingNil
  end
end
