class AddForeignKeyToPost < ActiveRecord::Migration[7.0]
  def change
    t.references :author, foreign_key: { to_table: 'users' }
  end
end
