class Comment < ApplicationRecord
    # attr_accessor :body
    validates :body, :presence => true
    
    belongs_to :user
    belongs_to :review
end
