class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|


      t.string :cd, index: true



      t.string :name



      t.integer :lock_version, default: 0, null: false
      t.integer :created_by
      t.integer :updated_by
      t.integer :deleted_by
      t.datetime :deleted_at


      t.timestamps

    end

  end
end