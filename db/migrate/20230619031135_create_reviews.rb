class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :body, null: false

      t.timestamps
      # t.belongs_to 
    end

    add_reference :reviews, :user, index: true #, foreign_key: true
  end
end
