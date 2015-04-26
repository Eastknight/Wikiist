class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validate :name, presence: true

  has_many :wikis
  has_many :collaboratings
  has_many :collaborating_wikis, through: :collaboratings, :source => :wiki
  before_create :init

  extend FriendlyId
  friendly_id :name, use: :slugged

  
  def admin?
    role == 'admin'
  end

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def upgrade!
    self.role = 'premium'
    self.save
  end

  private 

  def init
    self.role = 'standard'
  end
end
