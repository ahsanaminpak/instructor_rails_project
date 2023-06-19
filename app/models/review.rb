class Review < ApplicationRecord
    attr_accessible :body

    belongs_to :user
    has_many :comments
end
