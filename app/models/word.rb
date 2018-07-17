class Word < ApplicationRecord
  belongs_to :category, optional: true
  validates :content,presence: true
end
