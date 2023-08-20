class CommentsController < ApplicationController

  def create
    comment = current_user.comments.build(comment_params)

    if comment.save
      redirect_to search_result_path(params[:search_result_id]), success: 'コメントしました'
    else
      redirect_to search_result_path(params[:search_result_id]), error: 'コメントできませんでした'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:search_result_id])
    @comment.destroy!
    redirect_to search_result_path(params[:id]), success: 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(line_id: params[:search_result_id])
  end
end
