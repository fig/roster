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
#  provider               :string
#  uid                    :string
#  token                  :string
#
# Indexes
#
#  index_users_on_base_roster_id        (base_roster_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  belongs_to :base_roster
  has_one :profile
  accepts_nested_attributes_for :profile
  delegate :roster_epoch, :to => :profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.profile_attributes = {name_first: auth.info.first_name,
                                 name_last: auth.info.last_name}
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def current_line
    (((Date.today.beginning_of_week - roster_epoch) / 7).to_i) % base_roster.lines.size
  end

  def name
    profile.name_first + ' ' + profile.name_last
  end

  def short_name
    initial = profile.name_first.chars[0]
    initial + ' ' + profile.name_last
  end
end
