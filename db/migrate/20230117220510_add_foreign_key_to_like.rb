class AddForeignKeyToLike < ActiveRecord::Migration[7.0]
  def change
    t.references :author, foreign_key: { to_table: 'users' }
    t.references :post, foreign_key: true
  end
end
