class Express::Api::V1::EntriesController < Express::Api::V1::V1Controller

  def index
    @resources = @site.send(klass).open
    @resources = @resources.where(channel_id: params[:channel_id]) if params[:channel_id]
    @klass = klass
    render 'express/api/v1/shared/index'
  end

end
