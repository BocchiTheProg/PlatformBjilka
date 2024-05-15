class Order < ApplicationRecord
  def start_time
    date_order
  end

  belongs_to :client_profile
  # belongs_to :comment, optional: true
  has_many :comments, dependent: :destroy
  belongs_to :status
  belongs_to :urgency
  belongs_to :service

  has_one_attached :avatar

  accepts_nested_attributes_for :comments

  MAX_RATING = 5
  validates :rating, numericality: { in: 0..MAX_RATING }

  delegate :first_name, to: :client_profile, allow_nil: true
  delegate :last_name, to: :client_profile, allow_nil: true

  # def self.ransackable_associations(auth_object = nil)
  #   ["client_profile", "comments", "employee_profile", "service", "status", "urgency"]
  # end

  # def self.ransackable_attributes(auth_object = nil)
  #   ["client_profile_id", "created_at", "date_order", "employee_profile_id", "id", "id_value", "price", "service_id", "status_id", "updated_at", "urgency_id"]
  # end

  def self.ransackable_associations(auth_object = nil)
    ["avatar_attachment", "avatar_blob", "client_profile", "comments", "service", "status", "urgency"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["client_profile_id", "created_at", "date_order", "employee_profile_id", "id", "id_value", "price", "rating", "service_id", "status_id", "updated_at", "urgency_id"]
  end

  def self.to_csv
    attributes = %w[id client_profile status urgency service]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |order|
        csv << attributes.map { |attr| order.send(attr) }
      end
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end
