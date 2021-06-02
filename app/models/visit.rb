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
end
