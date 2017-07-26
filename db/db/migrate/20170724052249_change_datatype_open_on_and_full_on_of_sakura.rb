class ChangeDatatypeOpenOnAndFullOnOfSakura < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("TRUNCATE sakuras;")
    change_column :sakuras, :open_on, :integer
    change_column :sakuras, :full_on, :integer
  end
  def down
    ActiveRecord::Base.connection.execute("TRUNCATE sakuras;")
    change_column :sakuras, :open_on, :date
    change_column :sakuras, :full_on, :date
  end
end
