class RemoveStyleFromBeers < ActiveRecord::Migration
  def change
    remove_column :beers, :style, :integer
  end
end
