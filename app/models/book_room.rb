class BookRoom < ApplicationRecord
  belongs_to :room
  belongs_to :book
end
