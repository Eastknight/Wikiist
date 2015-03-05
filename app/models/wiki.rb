class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaboratings
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :visible_to, -> (user) {where(private: false) || where(user_id: user.id)}
end
