
class NoteRepresenter
  def initialize(note)
    @note = note
  end

  def to_json
    {
      id: note.id,
      name: note.name,
      content: note.content,
      folder_id: note.folder_id
    }
  end

  def to_compact_json
    {
      id: note.id
    }
  end

  private
  attr_reader :note
end