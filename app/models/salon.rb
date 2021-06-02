# == Schema Information
#
# Table name: salons
#
#  id          :integer          not null, primary key
#  address     :string
#  city        :string
#  description :string
#  name        :string
#  salon_type  :string
#  state       :string
#  street      :string
#  zip_code    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Salon < ApplicationRecord
  has_many(:visits, { :class_name => "Visit", :foreign_key => "salon_id", :dependent => :destroy })
end
