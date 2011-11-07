class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.references :contact, :null => false
      t.string :kind, :null => false
      t.string :label
      t.string :value, :null => false
      t.timestamps
    end
  end
end
