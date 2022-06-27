class User < ApplicationRecord
  enum kind: %i[knight wizard]

  validates :level, numericality: { greater_than: 0, less_than_or_equal_to: 99 }

  def title
    "#{kind} #{nickname} ##{level}"
  end
end
