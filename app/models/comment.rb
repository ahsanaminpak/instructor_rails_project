class Comment < ApplicationRecord
    attr_accessible :body

    
    belongs_to :user
    belongs_to :review
end
