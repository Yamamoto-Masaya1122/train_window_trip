class LinesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @line = Line.ransack(params[:q])
    @lines = @line.result
  end

  def show
    @line = Line.find(params[:id])
    @comment = Comment.new
    @comments = @line.comments.includes(:user).order(created_at: :desc)
    @commentable = @line
  end
end
