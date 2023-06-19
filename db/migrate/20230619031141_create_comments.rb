class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :body

      t.timestamps
    end

    add_reference :comments, :reviews, foreign_key: true
    add_reference :comments, :users, foreign_key: true

  end
end
