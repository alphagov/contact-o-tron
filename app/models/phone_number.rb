class PhoneNumber < ActiveRecord::Base
  KINDS = %w(phone fax minicom)

  belongs_to :contact

  validates :contact, :kind, :value, :presence => true
  validates :kind, :inclusion => { :in => KINDS }
end
