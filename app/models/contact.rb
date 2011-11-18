class Contact < ActiveRecord::Base
  has_many :phone_numbers, :inverse_of => :contact

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :phone_numbers, :allow_destroy => true, :reject_if => :all_blank

  scope :in_alphabetical_order, order(arel_table[:name].asc)
end
