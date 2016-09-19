class AddSpoCateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :spo_cate, :integer
  end
end
