class HomeController < ApplicationController
  def index 
      @folders = Folder.roots.order("name desc")   
      @assets = Asset.where("folder_id is NULL").order("uploaded_file_file_name desc")       
  end 
  def browse 
    @current_folder = Folder.find(params[:folder_id])   
    if @current_folder
      @folders = @current_folder.children 
      @assets  = @current_folder.assets.order("uploaded_file_file_name desc") 
      render :action => "index"
    else
      flash[:error] = "Don't be cheeky! Mind your own folders!"
      redirect_to root_url 
    end
  end

end
