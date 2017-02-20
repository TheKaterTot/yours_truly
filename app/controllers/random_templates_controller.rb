class RandomTemplatesController < ApplicationController
  def show
    category = Category.find(params[:id])
    template = category.templates.sample
    render json: template
  end
end
