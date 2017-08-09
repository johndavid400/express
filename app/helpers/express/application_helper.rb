module Express
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper

    def statuses
      [
        "open",
        "closed"
      ]
    end

    def subline(highlight, text)
      "<div class='subline'></div>".html_safe if highlight == text
    end

    def active(highlight, text)
      highlight == text ? "active" : "inactive"
    end

    def pagination_pages(count)
      c = count.to_i
      if c > 3
        ((c - 2)..(c + 2)).map{|s| s }
      else
        [1,2,3]
      end
    end

    def field_types
      {
        "Text Field" => "text_field",
        "Text Area" => "text_area",
        "Select" => "select",
        "Number" => "number_field",
        "Email" => "email_field",
        "Phone" => "telephone_field",
        "Checkbox" => "check_box",
        "Color" => "color_field",
        "Radio" => "radio_button",
        "Attachment" => "file_field"
      }
    end

    def groups_status
      @groups = cached_groups
    end

    def cached_groups
      url = 'https://groups.highlandsapp.com/api/v1/status'
      unless Rails.cache.read("groups").present?
        resp = Faraday.get(url).body
        groups = JSON.parse(resp)
        Rails.cache.write("groups", groups)
      end
      Rails.cache.read("groups")
    end

    def saturday_prayer_service_live
      time = Time.current.in_time_zone("Central Time (US & Canada)")
      int_rep = [time.hour, time.min].join.to_i
      # make sure current time is on a Saturday between 7:45am and 10:00am
      time.saturday? && int_rep >= 745 && int_rep < 1000
    end

  end
end
