class User < ActiveRecord::Base
  has_secure_password

  has_one :agenda, dependent: :destroy
  has_many :contacts, through: :agenda

  validates :username, :password, :password_confirmation, presence: true, on: :create
  validates :username, uniqueness: true
  validates :password, confirmation: true, on: :create

  before_save :format_attribute

  private
  def format_attribute
    self.username.downcase!
  end
end
