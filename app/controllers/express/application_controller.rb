module Express
  class ApplicationController < ActionController::Base
    include Express::ApplicationHelper
    protect_from_forgery with: :exception
    before_action :verify_admin, :set_title, :set_site

    def verify_admin
      @logout_link = "/logout"
      # override this in the host application to require some credentials
      redirect_to root_path, alert: "Admin access required" unless true
    end

    def set_title
      @title = params[:controller].split("/").last.titleize
    end

    def search
      @channel = Channel.friendly.find(params[:channel_id]) if params[:channel_id].present?
      if params[:search].present? || params[:channel_id].present?
        klass = params[:resource].classify.constantize
        if ["entries", "channels"].include?(params[:resource])
          @list = current_site.send(params[:resource])
        else
          @list = klass.order(created_at: :desc)
        end
        @list = @list.where(channel_id: params[:channel_id]) if params[:channel_id].present?
        @list = @list.search(params[:search]) if params[:search].present?
        render 'express/shared/search'
      end
    end

    def set_site
      @site = current_site
    end

    def validate_user
      current_user.present? && current_user.can_manage?(@site)
    end

    def set_channel
      id = params[:channel_id].present? ? params[:channel_id] : params[:id]
      @channel = current_site.channels.friendly.find(id)
    end

  end
end
