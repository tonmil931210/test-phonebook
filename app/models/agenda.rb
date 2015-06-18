class Agenda < ActiveRecord::Base
  belongs_to :user
  has_many :contacts, dependent: :delete_all
end
