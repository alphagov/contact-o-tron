class Contact < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  has_many :phone_numbers, :inverse_of => :contact

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :phone_numbers, :allow_destroy => true, :reject_if => :all_blank

  scope :in_alphabetical_order, order(arel_table[:name].asc)

  def uri
    contact_url self, :host => URI.parse(Plek.current.find('contactotron')).host
  end

  # Customise the payload lazily, so that the environment (e.g. Cucumber) gets
  # the opportunity to configure the transport before the client is created.
  def self.marples_client
    return @marples_client unless @marples_client.nil?

    @marples_client = super.tap do |client|
      client.payload_for self do |contact|
        contact.to_xml :except => contact.attribute_names, :methods => :uri
      end
    end
  end
end
