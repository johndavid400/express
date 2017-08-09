module Express
  module ApplicationHelper
    include FontAwesome::Rails::IconHelper

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

  end
end
