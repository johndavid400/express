class Express::EntriesController < Express::ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  after_action :set_data, only: [:create, :update]
  #after_action :handle_uploads, only: [:create, :update]

  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.order(:created_at)
    @entries = @entries.where(channel_id: params[:channel]) if params[:channel].present?
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = channel.present? ? Entry.new(channel_id: channel.id) : Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to express.edit_entry_path(@entry), notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to express.edit_entry_path(@entry), notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to express.entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title, :slug, :description, :data, :status, :open, :close, :user_id, :channel_id, :attachment)
    end

    def set_data
      data = params[:entry][:data]
      @entry.data = data
      handle_uploads
      @entry.save if @entry.changed?
    end

    def channel
      Channel.find(params[:channel_id]) rescue nil
    end

    def handle_uploads
      attachments = @entry.channel.custom_fields.select{|s| s["type"] == "file_field" }
      attachments.each do |attachment|
        file = params["entry"]["uploads"][attachment["key"]] rescue nil
        if file.present?
          upload = @entry.uploads.find_or_create_by(name: attachment["key"])
          upload.attachment = file
          upload.save
          @entry.data[attachment["key"]] = upload.id
        end
      end
    end

end
