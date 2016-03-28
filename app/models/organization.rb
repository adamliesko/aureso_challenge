class Organization < ActiveRecord::Base
  validates :auth_token, uniqueness: true
  validates :name, presence: true
  validates :public_name, presence: true
  validates :pricing_policy, presence: true
  validates :pricing_policy, inclusion: { in: %w(Flexible Fixed Prestige),
                                          message: '%{value} is not a valid pricing policy' }

  has_many :models
  has_many :model_types, through: :models

  before_create :set_auth_token

  def set_auth_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end

  def models_with_slug(slug)
    models.includes_model_type.with_model_slug(slug)
  end
end
