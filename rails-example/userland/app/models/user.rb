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

class User < ActiveRecord::Base

  def self.login(login, password)
    User.where(login: login, password: password).first
  end
end
