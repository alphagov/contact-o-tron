class Contact < ActiveRecord::Base
  has_many :phone_numbers

  validates :name, :presence => true, :uniqueness => true

  scope :in_alphabetical_order, order('name ASC')
end
