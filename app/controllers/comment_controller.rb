class CommentController < ApplicationController
  def my_comments
    @comments = Comment.where(:user_id => current_user.id).to_a
  end


  def create
    review = Review.where(:id => params[:review_id]).first
    @comment = review.comments.new(:body => params[:comment][:body], :user_id => current_user.id)

    if @comment.save!
      redirect_to review_path(params[:review_id])
    else
      redirect_to new_review_path
    end
  end

  def update
    comment = Comment.where(:id => params[:id]).first
    if comment.update(params.require(:comment).permit(:body))
      redirect_to review_path(params[:review_id])
    else
      redirect_to review_path(params[:review_id])
    end

  end

  def destroy
    comment = Comment.where(:id => params[:id]).first

    if comment.destroy
      redirect_to review_path(params[:review_id])
    else
      redirect_to review_path(params[:review_id])
    end
  end
  
end
