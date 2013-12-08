class AddConfirmableToUser < ActiveRecord::Migration
  def change
    add_column :users, :confirmation_token, :string, :unique => true
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    User.update_all(:confirmed_at => Time.now) # retroactively confirm all existing users
  end
end
