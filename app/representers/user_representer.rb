class UserRepresenter
  def initialize(user)
    @user = user
  end

  def to_json
    {
      id: user.id,
      name: user.name,
      email: user.email,
      created: user.created_at,
      folders: FoldersRepresenter.new(user.folders).to_compact_json
    }
  end

  private
  attr_reader :user
end