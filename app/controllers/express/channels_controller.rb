class Express::ChannelsController < Express::ApplicationController
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:index, :show]
  after_action :set_data, only: [:create, :update]

  # GET /channels
  # GET /channels.json
  def index
    @list = current_site.channels.order(title: :asc)
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
  end

  # GET /channels/new
  def new
    @channel = current_site.channels.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @channel = current_site.channels.new(channel_params)

    respond_to do |format|
      if @channel.save
        format.html { redirect_to express.edit_channel_path(@channel), notice: 'Channel was successfully created.' }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to express.edit_channel_path(@channel), notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
    respond_to do |format|
      format.html { redirect_to express.channels_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def channel_params
      params.require(:channel).permit(:title, :slug, :description, :data, :status, :attachment)
    end

    def set_data
      data = {"custom_fields" => params[:channel][:data]["custom_fields"].select{|s| s["name"].present? && s["key"].present? }}
      @channel.data = data
      @channel.save if @channel.changed?
    end

end
