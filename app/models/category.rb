class Category < ApplicationRecord
  has_many :libraries
  validates :name, presence: true
end
