class ReviewController < ApplicationController
  before_action :check_instructor, except: :index


  def index
    # @reviews = Review.all

    # review_cache_key = Review.all.cache_key_with_version
    # @reviews = Rails.cache.fetch("all_reviews/#{review_cache_key}") do
    #   Review.all
    # end
    @reviews = Review.all

  end

  def my_reviews
    # @reviews = Review.where(:user_id => current_user.id)

    review_cache_key = Review.where(:user_id => current_user.id).cache_key_with_version
    @reviews = Rails.cache.fetch("my_reviews/#{review_cache_key}") do
      Review.where(:user_id => current_user.id)
    end

  end


  def new
    @review = Review.new
  end

  def create
    # if  params[:review][:instructor_name] == ""
    #   flash.alert = "Instructor name cannot be empty."
    #   puts "here"
    #   redirect_to new_review_path, notice: "Ins cannot be empty."
    
    # elsif params[:review][:body] == ""
    #   flash.alert = "Review body cannot be empty."
    #   redirect_to new_review_path
    # end

    review = current_user.reviews.new(:body => params[:review][:body], :instructor_name => params[:review][:instructor_name])

    # if !@review.valid?
    #   flash.alert = "All fields are required. Please fill them to continue."
    # end

    if review.instructor_name == ""
      flash.alert = review.errors.full_messages[0]
# 8     render :new
      # flash.alert = "Instructor name cannot be empty."
      puts "here"
      redirect_to new_review_path, notice: "Ins cannot be empty."
    
    elsif review.body == ""
      flash.alert = "Review body cannot be empty."
      redirect_to new_review_path
    end

    if review.save
      flash.alert = "Review created successfully!"

      review_cache_key = review.cache_key_with_version
      # Rails.cache.write("review/#{review_cache_key}", review)

      redirect_to review
      # redirect_to review_path(@review.id)
    else
      flash.alert = "Review creation failed!"
      puts "something"
      redirect_to new_review_path
    end
  end

  def edit
    @review = Review.where(:id => params[:id]).first
  end

  def update
    # @review = Review.where(:id => params[:id]).first

    review_cache_key = Review.where(:id => params[:id]).first.cache_key_with_version
    # review = Rails.cache.fetch("review/#{review_cache_key}") do
    #   Review.where(:id => params[:id]).first
    # end

    review = Review.where(:id => params[:id]).first

    if review.update(params.require(:review).permit(:body, :instructor_name))
      review_cache_key = review.cache_key_with_version
      # Rails.cache.write("review/#{review_cache_key}", review)

      flash.alert = "Review updated successfully!"
      redirect_back(fallback_location: review)
      # redirect_to @review
    else
      flash.alert = "Review update failed!"
      redirect_back(fallback_location: review)
      # redirect_to new_review_path
    end

  end

  def destroy
    # @review = Review.where(:id => params[:id]).first
    review_cache_key = Review.where(:id => params[:id]).first.cache_key_with_version
    # review = Rails.cache.fetch("review/#{review_cache_key}") do
    #   Review.where(:id => params[:id]).first
    # end
    review = Review.where(:id => params[:id]).first

    if review.destroy
      flash.alert = "Review deleted successfully!"
      # Rails.cache.delete_matched("review/#{review_cache_key}")
      
      redirect_to new_review_path
      # redirect_back(fallback_location: new_review_path)
    else
      flash.alert = "Review deletion failed!"
      # redirect_to @review
      redirect_back(fallback_location: review)
    end
  end

  def show
    # @review = Review.where(:id => params[:id]).first

    # review_cache_key = Review.where(:id => params[:id]).first.cache_key_with_version
    # @review = Rails.cache.fetch("review/#{review_cache_key}") do
    #   Review.where(:id => params[:id]).first
    # end
    @review = Review.where(:id => params[:id]).first

    unless @review
      redirect_back(fallback_location: new_review_path)
    end


    @comments = @review.comments.to_a


    # comment_cache_key = @review.comments.cache_key_with_version
    # @comments = Rails.cache.fetch("comment/#{review_cache_key}/#{comment_cache_key}") do
    #   @review.comments.to_a
    # end

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