class RoomsController < ApplicationController
  def index
    @rooms = Room.all.order(created_at: :DESC)
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
      redirect_to rooms_path, success: t('.success')
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
