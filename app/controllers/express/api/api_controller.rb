class Express::Api::ApiController < ActionController::Base
  before_action :verify_key, :set_format

  def index
    @resources = @site.send(klass)
  end

  def show
    @resource = @site.send(klass)
  end

  def get(url, from_xml = false)
    #resp = Faraday.get(url, query: params.except("controller", "action").as_json).body
    resp = Faraday.get(url, params.except("controller", "action").as_json).body
    respond_to do |format|
      format.xml { render xml: resp }
      format.json { render json: from_xml ? Hash.from_xml(resp) : resp }
    end
  end

  private

  def base_url
    "https://api.churchofthehighlands.com/v2/media"
  end

  def verify_key
    authenticate_or_request_with_http_token do |token, options|
      if Site.exists?(key: token)
        @site = Site.find_by(key: token)
        true
      else
        false
      end
    end
  end

  def set_format
    request.format = :json unless params[:format].present?
  end

end
