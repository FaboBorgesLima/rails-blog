class AddDetailsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :description, :string
    add_column :users, :github_url, :string
    add_column :users, :linkedin_url, :string
    add_column :users, :linkedin_username, :string
  end
end
