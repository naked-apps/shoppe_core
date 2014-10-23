require 'awesome_nested_set'

module Shoppe
  class ProductCategory < ActiveRecord::Base
    # Allow the nesting of product categories
    acts_as_nested_set dependent: :restrict_with_exception
  
    self.table_name = 'shoppe_product_categories'
  
    # Categories have an image attachment
    attachment :image
  
    # All products within this category
    has_many :product_categorizations, dependent: :restrict_with_exception, class_name: 'Shoppe::ProductCategorization', inverse_of: :product_category
    has_many :products, class_name: 'Shoppe::Product', through: :product_categorizations
    
    # Validations
    validates :name, :presence => true
    validates :permalink, :presence => true, :uniqueness => true

    # All categories ordered by their name ascending
    scope :ordered, -> { order(:name) }

    # Root (no parent) product categories only
    scope :without_parent, -> { where(parent_id: nil) }
 
    # No descendents
    scope :except_descendants, ->(record) { where.not(id: (Array.new(record.descendants) << record).flatten) }
    
    # Set the permalink on callback
    before_validation { self.permalink = self.name.parameterize if self.permalink.blank? && self.name.is_a?(String) }
  
  end
end
