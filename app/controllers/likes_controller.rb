class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @line = Line.find(params[:line_id])
    current_user.line_like(@line)
  end

  def destroy
    @line = current_user.lines.find(params[:id])
    current_user.unlikes_line(@line)
  end
end
