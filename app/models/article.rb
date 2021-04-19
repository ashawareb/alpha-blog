class Article < ApplicationRecord
  belongs_to :user
  #title not null, Ensure there is a title and add minimum and maximum constarints
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :user_id, presence: true
end
