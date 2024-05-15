class ClientProfile < ApplicationRecord
  belongs_to :client, dependent: :destroy
  accepts_nested_attributes_for :client

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :orders, dependent: :destroy
  has_many :client_likes, dependent: :destroy
  has_many :services, through: :client_likes

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true

  has_one_attached :avatar

  def self.ransackable_associations(auth_object = nil)
    ["client", "client_likes", "orders", "services"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["client_id", "created_at", "first_name", "id", "id_value", "last_name", "phone", "updated_at"]
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ['avatar_attachment_id'] 
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ['avatar_attachment_id_eq']
  end

  # def self.ransackable_associations(auth_object = nil)
  #   ["avatar_attachment", "avatar_blob", "client", "client_likes", "orders", "services"]
  # end

  # def self.ransackable_attributes(auth_object = nil)
  #   ["client_id", "created_at", "currency_type", "first_name", "id", "id_value", "last_name", "phone", "updated_at"]
  # end

  # def self.ransackable_associations(auth_object = nil)
  #   ["avatar_attachment", "avatar_blob", "client", "client_likes", "orders", "services"]
  # end

  # def self.ransackable_attributes(auth_object = nil)
  #   ["client_id", "created_at", "currency_type", "first_name", "id", "id_value", "last_name", "phone", "updated_at"]
  # end

end
