class Entry < ApplicationRecord
  validates_presence_of :title
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  dragonfly_accessor :attachment
  belongs_to :channel
	has_many :uploads

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

	def self.growth_track
	  where("data ->> 'growth_track' = ?", "yes")
	end

  def get_data(key)
		key = key.first if key.is_a?(Array)
		data[key.to_s.titleize.parameterize] rescue nil
  end

  def method_missing(*args)
		# allows calling undefined json data keys as methods on entries - if none exists, resort to origin method_missing error
		get_data(args) rescue super
  end

	def self.next_gt_event
		Entry.event.growth_track.sort{|x,y| x.next_date <=> y.next_date }.first
	end

	def next_date
		# gets the next upcoming growth track date
		date_for_month(Date.current) < Date.current ? date_for_month(1.month.from_now) : date_for_month(Date.current)
	end

	def formatted_next_date
		next_date.strftime("%A, %B %-d")
	end

	def date_for_month(date)
		# gets the growth track date for Step (1,2,3,4) of the provided month
		if get_data("week").present?
			bom = date.beginning_of_month
			first_sunday = bom.wday == 0 ? bom : bom + (7 - bom.wday).days
			multiplier = (7 * get_data("week").to_i) - 7
			first_sunday + multiplier.days
		end
	end

	def find_upload(key)
		uploads.find(data[key]) rescue nil
	end

	def date_range
		if open.day == close.day
			open.strftime("%B %-d, %Y")
		elsif open.month != close.month
			"#{open.strftime("%B %-d")}—#{close.strftime("%B %-d, %Y")}"
		else
			"#{open.strftime("%B %-d")}—#{close.strftime("%-d, %Y")}"
		end
	end

end
