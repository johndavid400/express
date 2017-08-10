module Express
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :verify_admin, :set_title
    layout 'express/theme'

    def verify_admin
      # override this in the host application to require some credentials
      redirect_to root_path, alert: "Admin access required" unless true
    end

    def set_title
      @title = params[:controller].split("/").last.titleize
    end

  end
end
