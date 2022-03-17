
class NotesRepresenter
  def initialize(notes)
    @notes = notes
  end

  def to_json
    notes.map do |note|
      {
        id: note.id,
        name: note.name,
        content: note.content,
        folder_id: note.folder_id
      }
    end
  end

  def to_compact_json
    notes.map do |note|
      {
        id: note.id
      }
    end
  end

  private
  attr_reader :notes
end