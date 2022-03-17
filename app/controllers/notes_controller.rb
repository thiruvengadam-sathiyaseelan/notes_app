
class NotesController < ApplicationController

  def index
    check_session_and_raise
    @current_user = current_user
    @notes = Note.joins(folder: :user).where(users: {id: @current_user})
    if !@notes.nil? && @notes.length > 0
      render json: NotesRepresenter.new(@notes).to_json, status: 200
    end
  end

  def show
    check_session_and_raise
    @note = Note.joins(folder: :user).where(users: {id: @current_user}, notes: {id: params[:id]}).first
    if !@note.nil?
      render json: NoteRepresenter.new(@note).to_json, status: 200
    else
      render json: { "error" => "No record found" }, status: :not_found
    end
  end

  def create
    check_session_and_raise
    @current_user = current_user
    @folder = Folder.where(:id => params[:folder_id], :user_id => @current_user).first
    if !@folder.nil?
      @note = Note.new(note_params)
      if @note.save
        render json: NoteRepresenter.new(@note).to_json, status: :created
      else
        render json: @note.errors, status: :unprocessable_entity
      end
    else
      render json: { "error" => "Invalid target folder" }, status: :not_found
    end
  end

  def update
    @current_user = current_user
    @note = Note.joins(folder: :user).where(users: {id: @current_user}, notes: {id: params[:id]}).first
    if !@note.nil?
      @folder = Folder.where(:id => params[:folder_id], :user_id => @current_user).first
      if !@folder.nil?
        @note = Note.find(params[:id])
        @note.update_attributes(:name => params[:name], :content => params[:content], :folder_id => params[:folder_id])
        render json: {message: 'Note successfully updated.'}, status: 200
      else
        render json: { "error" => "Invalid target folder" }, status: :not_found
      end

    else
      render json: { "error" => "No record found" }, status: :not_found
    end
  end

  def destroy
    @current_user = current_user
    @note = Note.joins(folder: :user).where(users: {id: @current_user}, notes: {id: params[:id]}).first
    if !@note.nil?
        @note = Note.find(params[:id])
        @note.destroy
        render json: {message: 'Note deleted!'}, status: 200
    else
      render json: { "error" => "No record found" }, status: :not_found
    end
  end

  private
  def note_params
    params.slice(:id, :name, :content, :folder_id)
  end

end
