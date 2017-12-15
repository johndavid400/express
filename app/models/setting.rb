class Setting < ApplicationRecord
  validates_presence_of :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  include PgSearch
  pg_search_scope :search,
    :against => {
      :name => 'A',
      :description => 'B'
    },
    :using => {
      :tsearch => {:prefix => true}
    }

  def options
    data["options"].present? ? data["options"] : {}
  rescue
    {}
  end

  def option_values
    options.map{|s| [s["key"], s["value"]] }
  end

  private

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
