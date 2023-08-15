class SearchResultsController < ApplicationController
  def index
    @line = Line.ransack(params[:q])
    @lines = @line.result
  end

  def show
    @line = Line.find(params[:id])
  end
end
