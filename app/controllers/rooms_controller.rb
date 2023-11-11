class RoomsController < ApplicationController
  def new
    @line = Line.find(params[:line_id])
    @room = Room.new
  end

  def create
    @line = Line.find(params[:line_id])
    @room = @line.rooms.build(room_params)
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
