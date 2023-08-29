class LinesController < ApplicationController
  skip_before_action :require_login, only: %i[index show update_lines_options]

  def index
    @line = Line.ransack(params[:q])
    @lines = @line.result(distinct: true)
  end

  def show
    @line = Line.find(params[:id])
    @comment = Comment.new
    @comments = @line.comments.includes(:user).order(created_at: :desc)
    @commentable = @line
  end

  def update_lines_options
    selected_prefecture_id = params[:prefecture_id]
    lines = Line.joins(:prefecture_lines)
                .where(prefecture_lines: { prefecture_id: selected_prefecture_id })
                .order(:name)

    render json: { lines: lines }
  end
end
