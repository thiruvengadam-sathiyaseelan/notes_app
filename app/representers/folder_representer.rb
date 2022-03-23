
class FolderRepresenter
  def initialize(folder)
    @folder = folder
  end

  def to_json
    {
      id: folder.id,
      name: folder.name
    }
  end

  private
  attr_reader :folder
end

# migrate it to AMS https://github.com/rails-api/active_model_serializers