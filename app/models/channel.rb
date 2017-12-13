class Channel < ApplicationRecord
  validates_presence_of :title
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  dragonfly_accessor :attachment
  has_many :entries
  belongs_to :site

  include PgSearch
  pg_search_scope :search,
    :against => {
      :title => 'A',
      :description => 'B'
    },
    :using => {
      :tsearch => {:prefix => true}
    }

  def self.from_site(site_id)
    where(site_id: site_id)
  end

  def to_s
    title
  end

  def custom_fields
    data["custom_fields"] rescue {}
  end

  def data_fields
    data["custom_fields"].map{|s| [s["key"], ""] }.to_h
  end

  def data_keys
    data["custom_fields"].map{|s| s["key"].to_sym }
  end

end
