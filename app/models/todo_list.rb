class TodoList < ApplicationRecord
  has_many :todo_items

  validates :title, :description, presence: true
end
