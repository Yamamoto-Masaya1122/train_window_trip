class StaticPagesController < ApplicationController
  before_action :set_prefecture
  before_action :set_line
  before_action :set_category

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

  def set_category
    @category = Category.ransack(params[:q])
    @categories = @category.result
  end
end