# == Schema Information
#
# Table name: visits
#
#  id          :integer          not null, primary key
#  comment     :string
#  image       :string
#  likes_count :integer
#  rating      :integer
#  visit_date  :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  salon_id    :integer
#  user_id     :integer
#
class Visit < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })
  belongs_to(:salon, { :required => false, :class_name => "Salon", :foreign_key => "salon_id" })
  has_many(:likes, { :class_name => "Like", :foreign_key => "visit_id", :dependent => :destroy })
end
