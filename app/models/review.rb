class Review < ApplicationRecord
    # attr_accessor :users_id, :body

    validates :body, :presence => true
    validates :instructor_name, :presence => true


    belongs_to :user, touch: true
    has_many :comments, dependent: :destroy_async
end
