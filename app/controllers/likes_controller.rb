class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @line = Line.find(params[:line_id])
    current_user.line_like(@line)
    redirect_to request.referer
  end

  def destroy
    @line = current_user.lines.find(params[:id])
    current_user.unlikes_line(@line)
    redirect_to request.referer
  end
end
