class User < ActiveRecord::Base
  include GDS::SSO::User

  attr_accessible :uid, :email, :name, :permissions, as: :oauth

  serialize :permissions, Hash
end