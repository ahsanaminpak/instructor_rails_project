class ReviewController < ApplicationController
  before_action :check_instructor, except: :index


  def index
    @reviews = Review.all
  end

  def my_reviews
    @reviews = Review.where(:user_id => current_user.id)

  end


  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(:body => params[:review][:body], :instructor_name => params[:review][:instructor_name])

    if @review.save!
      flash.alert = "Review created successfully!"
      redirect_to @review
    else
      flash.alert = "Review creation failed!"
      redirect_to new_review_path
    end
  end

  def edit
    @review = Review.where(:id => params[:id]).first
  end

  def update
    @review = Review.where(:id => params[:id]).first
    if @review.update(params.require(:review).permit(:body, :instructor_name))
      flash.alert = "Review updated successfully!"
      redirect_back(fallback_location: @review)
      # redirect_to @review
    else
      flash.alert = "Review update failed!"
      redirect_back(fallback_location: @review)
      # redirect_to new_review_path
    end

  end

  def destroy
    @review = Review.where(:id => params[:id]).first
    if @review.destroy
      flash.alert = "Review deleted successfully!"
      # redirect_to new_review_path
      redirect_back(fallback_location: new_review_path)
    else
      flash.alert = "Review deletion failed!"
      # redirect_to @review
      redirect_back(fallback_location: @review)
    end
  end

  def show
    @review = Review.where(:id => params[:id]).first

    @comments = @review.comments.to_a

    # @comment = Comment.new
    # @comment.review_id = @review.id
  end

  protected

  def check_instructor
    if current_user.account_type == 2
      # flash[:error] = "Please log in."
      redirect_to authenticated_root_path
    end
  end

end

# , "users_id" => current_user.id