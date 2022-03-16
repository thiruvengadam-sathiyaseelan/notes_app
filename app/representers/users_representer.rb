
class UsersRepresenter
  def initialize(users)
    # binding.pry
    @users = users
  end

  def as_json
    users.map do |user|
    {
      id: user.id,
      name: user.name,
      email: user.email,
      created: user.created_at
    }
    end
  end

  private
  attr_reader :users
end
