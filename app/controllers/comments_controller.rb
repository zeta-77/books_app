class CommentsController < ApplicationController
  def create
    if params[:content] != ""
      comment = Comment.new(params.permit(:user_id, :commentable_id, :commentable_type, :content))
      comment.save
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: root_path)
  end
end
