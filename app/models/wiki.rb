class Wiki < ActiveRecord::Base
  
  validate :title, :body, presence: true
  belongs_to :user
  has_many :collaboratings
  has_many :collaborating_users, through: :collaboratings, :source => :user
  extend FriendlyId
  friendly_id :title, use: :slugged
  

  scope :visible_to, -> (user) {
    if !user
      where(private: false)
    else
      collabrated_wikis = Wiki.joins(:collaboratings).where(collaboratings: { user_id: user.id })
      public_wikis = Wiki.where("private = 'f'")
      owned_wikis = Wiki.where(user_id: user.id)
      if user.role == "admin"
        all
      else
        from("(#{collabrated_wikis.to_sql} UNION #{public_wikis.to_sql} UNION #{owned_wikis.to_sql}) AS wikis")
      end
    end
  }

end
