
class FolderRepresenter
  def initialize(folder)
    @folder = folder
  end

  def to_json
    binding.pry
    {
      id: folder.id,
      name: folder.name,
      user_id: folder.user_id,
      notes: NotesRepresenter.new(folder.notes).to_compact_json
    }
  end

  private
  attr_reader :folder
end