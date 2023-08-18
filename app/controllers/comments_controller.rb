class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)

    if comment.save
      redirect_to search_result_path(params[:search_result_id]), success: 'コメントしました'
    else
      redirect_to search_result_path(params[:search_result_id]), error: 'コメントできませんでした'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(line_id: params[:search_result_id])
  end
end
