FactoryGirl.define do
  factory :phone_number do
    contact
    kind    'phone'
    value   '01234 567890'
  end
end
