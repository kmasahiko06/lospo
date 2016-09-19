class AddPrefectureToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :prefecture, :integer
  end
end
