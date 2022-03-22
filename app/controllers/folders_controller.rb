class FoldersController < ApplicationController

  def index
    check_session_and_raise
    @folders = Folder.where(:user_id => current_user.id)
    if !@folders.nil? && @folders.length > 0 # @folders.present?, .blank? -> "", [], nil
      render json: FoldersRepresenter.new(@folders).to_json, status: 200
    end
  end

  def show
    check_session_and_raise
    # current_user.folders.find_by_id(params[:id])
    @folder = Folder.where(id: params[:id], user_id: current_user.id).first
    if !@folder.nil?
      render json: FolderRepresenter.new(@folder).to_json, status: 200
    else
      render json: { "error" => "No record found" }, status: :not_found
    end
  end

  # 'No record found' -> i18n

  def create
    check_session_and_raise
    # folder_params[user_id] = current_user.id
    @folder = Folder.new(folder_params) # .merge(user_id: current_user.id)
    @folder.user_id = current_user.id
    if @folder.save # .save! difference
      render json: FolderRepresenter.new(@folder).to_json, status: :created
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  def update
    @folder = Folder.where(:id => params[:id], :user_id => current_user.id).first # diff between where and find
    if !@folder.nil?
      @folder.update_attributes(:name => params[:name])
      render json: {message: 'Folder successfully updated.'}, status: 200
    else
      render json: { "error" => "No record found" }, status: :not_found
    end
  end

  def destroy
    @folder = Folder.where(:id => params[:id], :user_id => current_user.id).first
    if !@folder.nil?
      @folder.destroy # .destroy!
      render json: {message: 'Folder deleted.'}, status: 200
    else
      render json: { "error" => "No record found" }, status: :not_found
    end
  end

  private
  def folder_params
    params.slice(:id, :name, :user_id)
  end

end
