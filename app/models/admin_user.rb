class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # def self.ransackable_attributes(auth_object = nil)
  #    ["created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  # end

  def self.ransackable_attributes(auth_object = nil)
    ["blob_id", "name", "record_id", "record_type", "created_at", "email", "encrypted_password", "id", "id_value", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["blob_id", "created_at", "id", "id_value", "name", "record_id", "record_type"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ['email']
  end
end
