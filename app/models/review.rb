class Review < ApplicationRecord
    # attr_accessor :users_id, :body

    validates :body, :presence => true
    validates :instructor_name, :presence => true


    belongs_to :user, touch: true
    has_many :comments, dependent: :destroy_async

    settings index: { number_of_shards: 1 } do
        mappings dynamic: 'false' do
          indexes :instructor_name
          indexes :body
        end
    end
end
