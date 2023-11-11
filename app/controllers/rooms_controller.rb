class RoomsController < ApplicationController
  def index
    @rooms = Room.all.order(created_at: :DESC)
  end

  def show
    @room = Room.find(params[:id])
    @comment = Comment.new
    @comments = @room.comments.includes(:user).order(created_at: :asc)
  end

  def new
    @line = Line.find(params[:line_id])
    @room = Room.new
  end

  def create
    @line = Line.find(params[:line_id])
    @room = @line.rooms.build(room_params)
    @room.user = current_user
    if @room.save
      redirect_to room_path(@room), success: t('.success')
    else
      flash.now[:error] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name).merge(line_id: params[:line_id])
  end
end
