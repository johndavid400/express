class Entry < ApplicationRecord
  validates_presence_of :title
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  dragonfly_accessor :attachment
  belongs_to :channel
	has_many :uploads

  def to_s
    title
  end

	def self.open
		where(status: 'open')
	end

	def self.closed
		where(status: 'closed')
	end

  def self.method_missing(*args)
		# allow class method to get entries of a given entry type, if exists
		if Channel.pluck(:slug).include?(args.first.to_s)
			self.where(channel: Channel.friendly.find(args.first.to_s))
		else
			super
		end
  end

  def method_missing(*args)
		# allows calling undefined json data keys as methods on entries - if none exists, resort to original method_missing error
		if get_data(args).present?
		  get_data(args)
    else
      super
    end
  end

  def get_data(key)
		key = key.first if key.is_a?(Array)
		data[key.to_s.titleize.parameterize] rescue nil
  end

	def find_upload(key)
		uploads.find(data[key]) rescue nil
	end

end
