class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string    :title
      t.text      :description
      t.string    :image
      t.datetime  :pub_time
      t.string    :guid
      t.string    :link
      t.integer   :source_id
      t.string    :source_type

      t.timestamps
    end

    add_index :entries, :guid
    add_index :entries, [:source_id, :source_type]
  end
end
