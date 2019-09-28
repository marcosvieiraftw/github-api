class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :actor, foreign_key: true, on_delete: :cascade
      t.references :repo, foreign_key: true, on_delete: :cascade
      t.bigint :id_external
      t.string :event_type, limit: 30
      t.datetime :created_at
    end
    add_index :events, :id_external
    add_index :events, :created_at
  end
end
