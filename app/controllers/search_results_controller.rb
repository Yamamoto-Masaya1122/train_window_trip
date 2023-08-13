class SearchResultsController < ApplicationController
  def index
    @line = Line.ransack(params[:q])
    @lines = @line.result
  end
end
