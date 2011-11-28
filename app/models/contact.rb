class Contact < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  has_many :phone_numbers, :inverse_of => :contact

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :phone_numbers, :allow_destroy => true, :reject_if => :all_blank

  scope :in_alphabetical_order, order(arel_table[:name].asc)

  def uri
    contact_url self, :host => URI.parse(Plek.current.find('contactotron')).host
  end
end
