class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :body

      t.timestamps
    end

    add_reference :reviews, :users, foreign_key: true
  end
end
