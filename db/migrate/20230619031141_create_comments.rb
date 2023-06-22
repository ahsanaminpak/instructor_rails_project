class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :body, null: false

      t.timestamps
    end

    add_reference :comments, :review, index: true #, foreign_key: true
    add_reference :comments, :user, index: true #, foreign_key: true

  end
end
