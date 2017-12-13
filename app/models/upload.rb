class Upload < ApplicationRecord
  belongs_to :entry
  has_one :site, through: :entry
  has_one :channel, through: :entry

  dragonfly_accessor :attachment #do
#    storage_options do |attachment|
#      {
#        path: "#{site.slug}/#{channel.slug}/#{entry.slug}/uploads"
#      }
#    end
#  end

end
