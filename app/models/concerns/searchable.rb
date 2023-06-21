require "elasticsearch/model"

module Searchable
  extend ActiveSupport::Concern
  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    after_commit :index_document, if: :persisted?
    after_commit on: [:destroy] do
      # __elasticsearch__.delete_document
      __elasticsearch__.refresh_index!
    end
  end

  def self.search(query)
    self.__elasticsearch__.search(query)
  end
  
  private
  def index_document
    # __elasticsearch__.create_index!
    __elasticsearch__.index_document
  end
end
