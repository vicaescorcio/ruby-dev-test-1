class AssetsController < ApplicationController
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  # GET /assets
  # GET /assets.json
  def index
    @assets = Asset.all
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
  end

  # GET /assets/new
  def new     
    if params[:folder_id] 
     @current_folder = Folder.find(params[:folder_id]) 
     @asset = @current_folder.assets.build 
    else
      @asset = Asset.new
    end  
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = Asset.new(asset_params) 
    if @asset.save 
     flash[:notice] = "Successfully uploaded the file."
    
     if @asset.folder #checking if we have a parent folder for this file 
       redirect_to browse_path(@asset.folder)  #then we redirect to the parent folder 
     else
       redirect_to root_url 
     end      
    else
     render :action => 'new'
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset = Asset.find(params[:id]) 
    @parent_folder = @asset.folder #
    @asset.destroy 
    flash[:notice] = "Successfully deleted the file."
    
    if @parent_folder
     redirect_to browse_path(@parent_folder) 
    else
     redirect_to root_url 
    end
  end


  def get 
    asset = Asset.find_by_id(params[:id]) 
    if asset 
         send_file asset.uploaded_file.path, :type => asset.uploaded_file_content_type 
    end
  end
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = Asset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params.require(:asset).permit(:uploaded_file, :folder_id)
    end
end
