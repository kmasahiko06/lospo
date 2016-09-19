class AddBosyuuToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :bosyuu, :integer
  end
end
