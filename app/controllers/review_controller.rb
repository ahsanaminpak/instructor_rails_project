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

    @comments = @review.comments.to_a

    # @comment = Comment.new
    # @comment.review_id = @review.id
  end

  protected

  def check_instructor
    if current_user.account_type == 2
      flash[:error] = "Please log in."
      redirect_to authenticated_root_path
    end
  end

end

# , "users_id" => current_user.id