class CommentController < ApplicationController
  def my_comments
    @comments = Comment.where(:user_id => current_user.id).to_a
  end


  def create
    review = Review.where(:id => params[:review_id]).first
    @comment = review.comments.new(:body => params[:comment][:body], :user_id => current_user.id)

    if @comment.save!
      flash.alert = "Comment created successfully!"
      redirect_to review_path(params[:review_id])
    else
      flash.alert = "Comment creation failed!"
      # redirect_to new_review_path
      redirect_to review_path(params[:review_id])
    end
  end

  def update
    comment = Comment.where(:id => params[:id]).first
    if comment.update(params.require(:comment).permit(:body))
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
    comment = Comment.where(:id => params[:id]).first

    if comment.destroy
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
