class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true

  validates :password, presence: true, on: :create

  validates :password, confirmation: { case_sensitive: true }
  validates :password_confirmation, presence: true, on: :create

  validates :api_key, presence: true
  validates :api_key, uniqueness: true

  before_validation :set_api_key

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
