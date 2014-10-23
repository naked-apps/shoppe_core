class AddNestedToCategories < ActiveRecord::Migration
  def up
    add_column :shoppe_product_categories, :parent_id, :integer
    add_column :shoppe_product_categories, :lft, :integer
    add_column :shoppe_product_categories, :rgt, :integer
    add_column :shoppe_product_categories, :depth, :integer

    add_index :shoppe_product_categories, :lft
    add_index :shoppe_product_categories, :rgt
    
    Shoppe::ProductCategory.reset_column_information
    Shoppe::ProductCategory.rebuild!
  end

  def down
    remove_column :shoppe_product_categories, :parent_id
    remove_column :shoppe_product_categories, :lft
    remove_column :shoppe_product_categories, :rgt
    remove_column :shoppe_product_categories, :depth
  end
end
