class Store < ApplicationRecord
  validates_presence_of :name, :description, :image
  validates_uniqueness_of :name
  has_many :items
  has_many :user_roles
  has_many :users, through: :user_roles

  enum status: ["online", "offline", "pending", "rejected"]

  def retire_items
    items.map do |item|
      item.update_columns(status: 1)
    end
  end

  def activate_items
    items.map do |item|
      item.update_columns(status: 0)
    end
  end

  def check_image
    begin
      escaped_address = URI.escape(image)
      address = URI.parse(escaped_address)
      response = Net::HTTP.get_response(address)
      return true
    rescue
      return false
    end
  end

end
