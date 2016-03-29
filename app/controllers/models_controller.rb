class ModelsController < ApplicationController
  def organization_models
    @models = @organization.models_with_slug(params[:model_slug])
  end
end
