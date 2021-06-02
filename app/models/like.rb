# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  visit_id   :integer
#
class Like < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "fan_id" })
  belongs_to(:visit, { :required => false, :class_name => "Visit", :foreign_key => "visit_id", :counter_cache => true })
end
