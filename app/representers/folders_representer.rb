
class FoldersRepresenter
  def initialize(folders)
    @folders = folders
  end

  def to_json
    folders.map do |folder|
      {
        id: folder.id,
        name: folder.name
      }
    end
  end

  def to_compact_json
    folders.map do |folder|
      {
        id: folder.id
      }
    end
  end

  private
  attr_reader :folders
end
