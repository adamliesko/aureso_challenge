class ModelTypesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def price
    @model_type = ModelType.with_custom_price(@organization, permitted_params)
  end

  private

  def permitted_params
    params.permit(:base_price, :model_slug, :model_type_slug)
  end

  def record_not_found
    render json: { message: '404 - Not Found' }, status: 404
  end
end
