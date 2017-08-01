class ChangeDatatypeOpenOnAndFullOnOfSakura < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == "mysql2"
      ActiveRecord::Base.connection.execute("TRUNCATE sakuras;")
      change_column :sakuras, :open_on, :integer
      change_column :sakuras, :full_on, :integer
    else
      change_column :sakuras, :open_on, 'integer USING NULL'
      change_column :sakuras, :full_on, 'integer USING NULL'
    end
  end
  def down
    ActiveRecord::Base.connection.execute("TRUNCATE sakuras;")
    change_column :sakuras, :open_on, :date
    change_column :sakuras, :full_on, :date
  end
end
