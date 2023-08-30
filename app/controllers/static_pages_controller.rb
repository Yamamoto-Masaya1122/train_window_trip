class StaticPagesController < ApplicationController
  before_action :set_prefecture
  before_action :set_line
  skip_before_action :require_login, only: %i[top]

  def top; end

  private

  def set_prefecture
    @prefecture = Prefecture.ransack(params[:q])
    @prefectures = @prefecture.result
  end

  def set_line
    @line = Line.ransack(params[:q])
    @lines = @line.result
  end
end