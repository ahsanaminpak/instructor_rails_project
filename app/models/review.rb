class Review < ApplicationRecord
    # attr_accessor :users_id, :body

    validates :body, :presence => true
    validates :instructor_name, :presence => true


    belongs_to :user, touch: true
    has_many :comments, dependent: :destroy_async

    # include Searchable

    # settings index: { number_of_shards: 1 } do
    #   mappings dynamic: 'false' do
    #     indexes :body
    #     indexes :instructor_name
    #   end
    # end
end
