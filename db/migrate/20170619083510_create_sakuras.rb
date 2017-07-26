class CreateSakuras < ActiveRecord::Migration
  def change
    create_table :sakuras do |t|


      t.references :place, index: true, foreign_key: false



      t.integer :year



      t.date :open_on



      t.date :full_on



      t.integer :lock_version, default: 0, null: false
      t.integer :created_by
      t.integer :updated_by
      t.integer :deleted_by
      t.datetime :deleted_at


      t.timestamps

    end

    add_index :sakuras, :year

    add_index :sakuras, :open_on

    add_index :sakuras, :full_on

  end
end