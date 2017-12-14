class Express::Api::ApiController < ActionController::Base
  include Express::ApplicationHelper
  before_action :verify_key, :set_format

  def index
    @resources = @site.send(klass)
    @klass = klass
    render 'express/api/v1/shared/index'
  end

  def show
    @resource = @site.send(klass).find(params[:id])
    @klass = klass.singularize
    render 'express/api/v1/shared/show'
  end

  private

  def verify_key
    if current_user && current_user.can_manage_api?
      # allow logged-in supreadmin users to view api in browser without Auth header set
      @site = Site.find(params[:site_id])
      true
    else
      authenticate_or_request_with_http_token do |token, options|
        if Site.exists?(key: token)
          @site = Site.find_by(key: token)
          true
        else
          false
        end
      end
    end
  end

  def set_format
    request.format = :json unless params[:format].present?
  end

  def klass
    params[:controller].split("/").last
  end

end
