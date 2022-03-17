
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
      include: [:notes]
    }
  end

  private
  attr_reader :folder
end