class Setting < ApplicationRecord
  validates_presence_of :name
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def options
    data["options"].present? ? data["options"] : {}
  rescue
    {}
  end

  def option_values
    options.map{|s| [s["key"], s["value"]] }
  end

end
