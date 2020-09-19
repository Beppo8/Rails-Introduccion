class Article < ApplicationRecord
    has_rich_text :content
    belongs_to :user #campo adicional
end
