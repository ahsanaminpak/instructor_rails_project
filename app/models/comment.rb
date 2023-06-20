class Comment < ApplicationRecord
    # attr_accessor :body
    validates :body, :presence => true
    
    belongs_to :user, touch: true
    belongs_to :review, touch: true
end
