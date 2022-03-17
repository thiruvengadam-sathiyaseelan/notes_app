
class UsersRepresenter
  def initialize(users)
    # binding.pry
    @users = users
  end

  def to_json
    users.map do |user|
    {
      id: user.id,
      name: user.name,
      email: user.email,
      created: user.created_at,
      folders: FoldersRepresenter.new(user.folders).to_compact_json
    }
    end
  end

  private
  attr_reader :users
end
