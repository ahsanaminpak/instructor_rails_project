class Comment < ApplicationRecord
    # attr_accessor :body

    
    belongs_to :user
    belongs_to :review
end
