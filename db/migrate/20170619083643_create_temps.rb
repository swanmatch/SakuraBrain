class CreateTemps < ActiveRecord::Migration
  def change
    create_table :temps do |t|


      t.references :place, index: true, foreign_key: false



      t.date :temp_on



      t.integer :average



      t.integer :max



      t.integer :min



      t.integer :lock_version, default: 0, null: false
      t.integer :created_by
      t.integer :updated_by
      t.integer :deleted_by
      t.datetime :deleted_at


      t.timestamps

    end

    add_index :temps, :temp_on

    add_index :temps, :average

    add_index :temps, :max

    add_index :temps, :min

  end
end