class ChangeStyleFormatInBeers < ActiveRecord::Migration
  def change
    Beer.find(:all).each { |b| b.style = (Style.all.find { |s| s.name == b.style }).id }
    change_column :beers, :style, :integer
  end
end
