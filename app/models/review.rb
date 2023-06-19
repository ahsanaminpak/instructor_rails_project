class Review < ApplicationRecord
    # attr_accessor :users_id, :body

    belongs_to :user
    has_many :comments
end
