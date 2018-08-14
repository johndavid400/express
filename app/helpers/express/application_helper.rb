module Express
  module ApplicationHelper

    def current_site
      cs = cookies.permanent.signed[:site_id]
      if cs.present?
        Site.friendly.find(cs)
      else
        cookies.permanent.signed[:site_id] = Site.default.id
        Site.default
      end
    rescue
      cookies.permanent.signed[:site_id] = nil
    end

    def current_user
      User.new
    end

    def statuses
      [
        "open",
        "closed"
      ]
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

    def key_includes?(key, value)
      key.include?(value) rescue false
    end

    def channel_name(id)
      Channel.find(id) rescue "Entry"
    end

    def fa_icon(icon, options = nil)
      "<i class='fas fa-#{icon} #{options[:class] if options.present? && options[:class].present?}'></i>".html_safe
    end

  end
end
