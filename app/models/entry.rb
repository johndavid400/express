class Entry < ApplicationRecord
  validates_presence_of :title
  belongs_to :channel
	has_many :uploads, dependent: :destroy
  has_one :site, through: :channel

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  dragonfly_accessor :attachment #do
#    storage_options do |attachment|
#      {
#        path: "#{site.slug}/#{channel.slug}/#{slug}"
#      }
#    end
#  end

  include PgSearch
  pg_search_scope :search,
    :against => {
      :title => 'A',
      :description => 'B'
    },
    :using => {
      :tsearch => {:prefix => true}
    }

  scope :open,  -> { where(status: "open") }
  scope :closed,  -> { where(status: "closed") }

  def self.from_site(site_id)
    self.includes(:channel).where(channels: {site_id: site_id})
  end

  def to_s
    title
  end

  def self.method_missing(*args)
		# allow class method to get entries of a given entry type, if exists
		if Channel.pluck(:slug).include?(args.first.to_s)
			self.where(channel: Channel.friendly.find(args.first.to_s))
		else
			super
		end
  end

  def user
    # override this method in host application
    "Admin"
  end

  def method_missing(*args)
		# allows calling undefined json data keys as methods on entries - if none exists, resort to original method_missing error
    get_data(args).nil? ? super : get_data(args)
  end

  def get_data(key)
		key = key.first if key.is_a?(Array)
		data[key.to_s.titleize.parameterize] rescue nil
  end

	def find_upload(key)
		uploads.find(data[key]) rescue nil
	end

  def attachment_url
    [ENV["EXPRESS_IMAGE_BASE_URL"], attachment_uid].join
  end

  def custom
    data.merge(data_upload_urls)
  end

  def data_upload_keys
    channel.data["custom_fields"].select{|s| s["type"] == "file_field" }.map{|s| s["key"] }
  end

  def data_upload_urls
    data.select{|k,v| data_upload_keys.include?(k) }.map{|k,v| [k, Upload.find(v).attachment_url] }.to_h
  end

  def as_json(options = {})
    super(options.merge(:except => [:data], :methods => [:attachment_url, :custom]))
  end

  private

  def should_generate_new_friendly_id?
    slug.blank?
  end

end
