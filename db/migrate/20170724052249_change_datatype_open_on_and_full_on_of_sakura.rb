class ChangeDatatypeOpenOnAndFullOnOfSakura < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("TRUNCATE sakuras;")
    change_column :sakuras, :open_on, 'integer USING open_on::int'
    change_column :sakuras, :full_on, 'integer USING full_on::int'
  end
  def down
    ActiveRecord::Base.connection.execute("TRUNCATE sakuras;")
    change_column :sakuras, :open_on, :date
    change_column :sakuras, :full_on, :date
  end
end
