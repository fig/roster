# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  base_roster_id         :integer
#
# Indexes
#
#  index_users_on_base_roster_id        (base_roster_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  has_one :profile
  belongs_to :base_roster
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def current_line
    (((Date.today.beginning_of_week - profile.roster_epoch) / 7).to_i) % base_roster.lines.count
  end
  
  def name
    profile.name_first + ' ' + profile.name_last
  end
  
  def short_name
    initial = profile.name_first.chars[0]
    initial + ' ' + profile.name_last
  end
end
