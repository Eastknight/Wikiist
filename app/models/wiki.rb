class Wiki < ActiveRecord::Base
  belongs_to :user
  extend FriendlyId
  friendly_id :title, use: :slugged
end
