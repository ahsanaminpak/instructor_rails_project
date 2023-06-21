class Comment < ApplicationRecord
    # attr_accessor :body
    validates :body, :presence => true
    
    belongs_to :user, touch: true
    belongs_to :review, touch: true

    include Searchable
    
    settings index: { number_of_shards: 1 } do
        mappings dynamic: 'false' do
          indexes :body
        end
    end
end
