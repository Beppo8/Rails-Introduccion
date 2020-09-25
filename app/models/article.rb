class Article < ApplicationRecord
    has_rich_text :content
    belongs_to :user #campo adicional
    has_many :has_categories
    has_many :categories, through: :has_categories
    attr_accessor :category_elements

    def save_categories
        # category_elements 1,2,3
        # Convertir eso en un elemento 1,2,3 => [1,2,3]
        categories_array = category_elements.split(",")
        # Iterar ese arreglo
        return has_categories.destroy.all if category_elements.nil? || category_elements.empty?

        has_categories.where.not(category_id: category_elements).destroy_all

        categories_array.each do |category_id|
            # Crear HasCategory HasCategory<article_id: 1,category_id:
            HasCategory.find_or_create_by(article: self,category_id: category_id)
        end
    end
end
