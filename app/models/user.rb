# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
  has_many(:visits, { :class_name => "Visit", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:likes, { :class_name => "Like", :foreign_key => "fan_id", :dependent => :destroy })
  has_many(:follow_requests, { :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy })
end
