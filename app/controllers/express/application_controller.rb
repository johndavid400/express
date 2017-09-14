module Express
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :verify_admin, :set_title

    def verify_admin
      # override this in the host application to require some credentials
      redirect_to root_path, alert: "Admin access required" unless true
    end

    def set_title
      @title = params[:controller].split("/").last.titleize
    end

    def search
      if params[:search].present? || params[:channel_id].present?
        klass = params[:resource].classify.constantize
        @list = klass.order(created_at: :desc)
        @list = @list.where(channel_id: params[:channel_id]) if params[:channel_id].present?
        @list = @list.search(params[:search]) if params[:search].present?
        render 'express/shared/search'
      end
    end

  end
end
