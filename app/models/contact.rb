class Contact < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  scope :in_alphabetical_order, order('name ASC')
end
