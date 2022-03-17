class FoldersController < ApplicationController

  def index
    check_session_and_raise
    @folders = Folder.where(:user_id => current_user)
    if !@folders.nil? && @folders.length > 0
      render json: FoldersRepresenter.new(@folders).to_json, status: 200
    end
  end

  def show
    check_session_and_raise
    @folder = Folder.where(:id => params[:id], :user_id => current_user)
    if !@folder.nil? && @folder.length > 0
      render json: FolderRepresenter.new(@folder).to_json, status: 200
    else
      render json: { "error" => "No record found" }, status: :not_found
    end
  end

  def create
    check_session_and_raise
    @folder = Folder.new(folder_params)
    if @folder.save
      render json: FolderRepresenter.new(@folder).to_json, status: :created
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  private
  def folder_params
    params.slice(:id, :name, :user_id)
  end

end
