# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  name_first   :string           default("")
#  name_last    :string           default("")
#  roster_epoch :date
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  preference   :string
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

class Profile < ActiveRecord::Base
  belongs_to :user
end
