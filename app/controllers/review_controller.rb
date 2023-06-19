class ReviewController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(:body => params[:review][:body])

    if @review.save!
      redirect_to @review
    else
      redirect_to new_review_path
    end
  end

  def edit
    @review = Review.where(:id => params[:id]).first
  end

  def update
    @review = Review.where(:id => params[:id]).first
    if @review.update(params.require(:review).permit(:body))
      redirect_to @review
    else
      redirect_to new_review_path
    end

  end

  def destroy
    @review = Review.where(:id => params[:id]).first
    if @review.destroy
      redirect_to new_review_path
    else
      redirect_to @review
    end
  end

  def show
    @review = Review.where(:id => params[:id]).first
  end

end

# , "users_id" => current_user.id