class CommentController < ApplicationController
  def my_comments
    @comments = Comment.where(:user_id => current_user.id).to_a
  end


  def create
    review = Review.where(:id => params[:review_id]).first
    @comment = review.comments.new(:body => params[:comment][:body], :user_id => current_user.id)

    if @comment.save!
      comment_cache_key = @comment.cache_key_with_version
      Rails.cache.write("comment/#{comment_cache_key}", @comment)

      flash.alert = "Comment created successfully!"
      redirect_to review_path(params[:review_id])
    else
      flash.alert = "Comment creation failed!"
      # redirect_to new_review_path
      redirect_to review_path(params[:review_id])
    end
  end

  def update
    # comment = Comment.where(:id => params[:id]).first
    # Rails.cache.clear # remove

    comment_cache_key = Comment.where(:id => params[:id]).first.cache_key_with_version
    @comment = Rails.cache.fetch("comment/#{comment_cache_key}") do
      Comment.where(:id => params[:id]).first
    end

    if @comment.update(params.require(:comment).permit(:body))
      Rails.cache.write("comment/#{comment_cache_key}", @comment)

      flash.alert = "Comment updated successfully!"
      # redirect_to review_path(params[:review_id])
      redirect_back(fallback_location: review_path(params[:review_id]))
    else
      flash.alert = "Comment update failed!"
      # redirect_to review_path(params[:review_id])
      # redirect_to :back
      redirect_back(fallback_location: review_path(params[:review_id]))
    end

  end

  def destroy
    # comment = Comment.where(:id => params[:id]).first

    comment_cache_key = Comment.where(:id => params[:id]).first.cache_key_with_version
    comment = Rails.cache.fetch("comment/#{comment_cache_key}") do
      Comment.where(:id => params[:id]).first
    end

    if comment.destroy
      # Rails.cache.delete_matched("comment/#{comment_cache_key}")

      flash.alert = "Comment deleted successfully!"
      # redirect_to review_path(params[:review_id])
      redirect_back(fallback_location: review_path(params[:review_id]))
    else
      flash.alert = "Comment deletion failed!"
      # redirect_to review_path(params[:review_id])
      redirect_back(fallback_location: review_path(params[:review_id]))
    end
  end
  
end
