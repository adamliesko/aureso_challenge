class Model < ActiveRecord::Base
  extend FriendlyId
  friendly_id :model_slug, use: :slugged, slug_column: :model_slug

  validates :name,          presence: true, uniqueness: true
  validates :model_slug,    presence: true, uniqueness: true
  validates :organization,  presence: true

  belongs_to :organization
  has_many :model_types

  scope :with_model_slug, -> (slug) { where(model_slug: slug) }
  scope :includes_model_type, -> () { includes(:model_types) }
  scope :with_model_type_slug, -> (slug) { joins(:model_types).where('model_types.model_type_slug = ?', slug) }
end
