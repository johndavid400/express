class Site < ApplicationRecord
  validates_presence_of :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_many :channels

  include PgSearch
  pg_search_scope :search,
    :against => {
      :name => 'A',
      :description => 'B'
    },
    :using => {
      :tsearch => {:prefix => true}
    }

  def self.default
    Site.exists? ? Site.first : Site.create(name: "Default")
  end

  def self.selectable?
    Site.default && Site.count > 1
  end

  def entries
    Entry.where(channel: channels)
  end

end

