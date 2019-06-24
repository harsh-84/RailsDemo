class AddPrivacyToFeed < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :privacy, :string
  end
end
