class ModelType < ActiveRecord::Base
  extend FriendlyId
  friendly_id :model_type_slug, use: :slugged, slug_column: :model_type_slug

  validates :name, presence: true, uniqueness: true
  validates :model_type_slug, presence: true, uniqueness: true
  validates :model_type_code, presence: true, uniqueness: true
  validates :base_price, presence: true

  belongs_to :model

  scope :with_model_type_slug, -> (slug) { where(model_type_slug: slug) }
  scope :with_model_slug, -> (slug) { joins(:model).where('models.model_slug = ?', slug) }

  def self.with_custom_price(organization, opts)
    model_type = organization.model_types.with_model_slug(opts[:model_slug]).with_model_type_slug(opts[:model_type_slug]).first
    if model_type
      model_type.base_price = opts[:base_price] # don't save the base price, in this case, use it as a per request attribute
      model_type
    else
      fail ActiveRecord::RecordNotFound
    end
  end

  def total_price
    price_calculator = "PriceCalculators::#{model.organization.pricing_policy}PriceCalculator".constantize.new(base_price)
    price_calculator.total_price.to_i
  end
end
