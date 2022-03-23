class FoldersController < ApplicationController

  before_filter :check_session_and_raise
  before_filter :set_folder, only: [:show, :destroy, :update]

  def index
    folders = current_user.folders
    render json: FoldersRepresenter.new(folders).to_json, status: 200
  end

  def show
    if @folder.present?
      render json: FolderRepresenter.new(@folder).to_json, status: 200
    else
      render json: { error: I18n.t(:not_found, scope: [:folder]) }, status: :not_found
    end
  end

  def create
    folder = Folder.new(folder_params.merge(user_id: current_user.id))
    if folder.save # .save! difference
      render json: FolderRepresenter.new(folder).to_json, status: :created
    else
      render json: folder.errors, status: :unprocessable_entity
    end
  end

  def update
    if @folder.present?
      @folder.update_attributes(:name => params[:name])
      render json: {message: I18n.t(:updated, scope: [:folder])}, status: 200
    else
      render json: { error: I18n.t(:not_found, scope: [:folder]) }, status: :not_found
    end
  end

  def destroy
    if @folder.present?
      @folder.destroy # .destroy!
      render json: {message: I18n.t(:deleted, scope: [:folder])}, status: 200
    else
      render json: { error: I18n.t(:not_found, scope: [:folder]) }, status: :not_found
    end
  end

  private
  def folder_params
    params.slice(:id, :name, :user_id)
  end

  def set_folder
    if current_user.present?
      @folder = current_user.folders.find(params[:id])
    end
  end
end
