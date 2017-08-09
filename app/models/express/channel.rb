class Channel < ApplicationRecord
  validates_presence_of :title
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  dragonfly_accessor :attachment
  has_many :entries

  def to_s
    title
  end

  def custom_fields
    data["custom_fields"] rescue {}
  end

end
