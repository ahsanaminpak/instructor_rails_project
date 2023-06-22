class AddInstructorNameColumnToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :instructor_name, :string
  end
end
