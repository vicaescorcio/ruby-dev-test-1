class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @folders = Folder.all
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
  end

  # GET /folders/new
  def new
    @folder = Folder.new      
    if params[:folder_id] 
      @current_folder = Folder.find(params[:folder_id])   
      @folder.parent_id = @current_folder.id 
    end
  end

  # GET /folders/1/edit
  def edit
    @folder = Folder.find(params[:id]) 
    @current_folder = @folder.parent  
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = Folder.new(folder_params) 
    if @folder.save 
     flash[:notice] = "Successfully created folder."
       
     if @folder.parent #checking if we have a parent folder on this one 
       redirect_to browse_path(@folder.parent)  #then we redirect to the parent folder 
     else
       redirect_to root_url #if not, redirect back to home page 
     end
    else
     render :action => 'new'
    end
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to @folder, notice: 'Folder was successfully updated.' }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder = Folder.find(params[:id]) 
    @parent_folder = @folder.parent 
    @folder.destroy 
    flash[:notice] = "Successfully deleted the folder and all the contents inside."
    
    if @parent_folder
     redirect_to browse_path(@parent_folder) 
    else
     redirect_to root_url    
    end   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :parent_id)
    end
end
