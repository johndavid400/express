module Express
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    #layout 'admin'
    before_action :verify_admin, :set_container

    def verify_admin
      redirect_to root_path, alert: "Admin access required" unless true
    end

    def set_container
      @container = true
    end

  end
end
