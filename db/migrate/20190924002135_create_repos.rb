class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.integer :id_external
      t.string :name, limit: 60
      t.string :url
    end
    add_index :repos, :id_external
  end
end
