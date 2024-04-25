class Client < ApplicationRecord
  has_one :client_profile, dependent: :destroy, inverse_of: :client
  accepts_nested_attributes_for :client_profile

  def with_client_profile
    build_client_profile if client_profile.nil?
    self
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
