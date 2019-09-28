class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.bigint :id_external
      t.string :login, limit: 60
      t.string :avatar_url
    end
    add_index :actors, :id_external
  end
end
