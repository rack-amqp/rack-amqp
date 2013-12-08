# == Schema Information
# Schema version: 20131207163108
#
# Table name: users
#
#  id         :integer          not null, primary key
#  login      :string(255)
#  password   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  describe "#login" do
    before :all do
      @login       = "doge"
      @password    = "wow! so secure! such password!"
      @sample_user = User.create(login: @login, password: @password)
    end

    it "should login a user" do
      User.login(@login, @password).should == @sample_user
    end

    it "should not login a user with a bad password" do
      User.login(@login, "#{@password}-wrong").should be_nil
    end
  end
end
