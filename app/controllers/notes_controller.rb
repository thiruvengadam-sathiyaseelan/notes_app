class NotesController < ApplicationController

  before_filter :check_session_and_raise
  before_filter :set_folder
  before_filter :set_note, only: [:show, :destroy, :update]

  def index
    if @folder.present?
        render json: NotesRepresenter.new(@folder.notes).to_json, status: 200
    else
      render json: { error: I18n.t(:not_found, scope: [:note]) }, status: :not_found
    end
  end

  def show
    if @note.present?
      render json: NoteRepresenter.new(@note).to_json, status: 200
    else
      render json: { error: I18n.t(:not_found, scope: [:note]) }, status: :not_found
    end
  end

  def create
    if @folder.present?
      @note = @folder.notes.build(note_params)
      if @note.save
        render json: NoteRepresenter.new(@note).to_json, status: :created
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    else
      render json: { error: I18n.t(:invalid_folder, scope: [:note]) }, status: :not_found
    end
  end

  def update
    if @note.present?
      @note.update_attributes(name: params[:name], content: params[:content], folder_id: params[:folder_id])
      render json: { message:  I18n.t(:updated, scope: [:note]) }, status: 200
    else
      render json: { error: I18n.t(:invalid_folder, scope: [:note]) }, status: :not_found
    end
  end

  def destroy
    if @note.present?
      @note.destroy
      render json: { message: I18n.t(:deleted, scope: [:note]) }, status: 200
    else
      render json: { error: I18n.t(:not_found, scope: [:note]) }, status: :not_found
    end
  end

  private

  def note_params
    params.slice(:id, :name, :content)
  end

  def set_folder
    @folder = current_user.folders.find(params[:folder_id])
  end

  def set_note
    if @folder.present? then
      @note = @folder.notes.find(params[:id])
    end
  end
end
