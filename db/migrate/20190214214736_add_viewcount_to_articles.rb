class AddViewcountToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :view_count, :integer
  end
end
