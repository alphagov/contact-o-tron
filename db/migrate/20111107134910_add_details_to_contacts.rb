class AddDetailsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :postal_address, :text
    add_column :contacts, :email_address, :string
    add_column :contacts, :website_url, :string
    add_column :contacts, :opening_hours, :text
  end
end
