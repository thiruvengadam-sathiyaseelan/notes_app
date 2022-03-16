class UsersController < ApplicationController

  # GET /users
  def index
    @users = User.all
    render json: UsersRepresenter.new(@users).as_json
  end

  # GET /user/:id
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      # binding.pry
      render json: UserRepresenter.new(@user).as_json, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: {message: 'User successfully updated.'}, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      render json: {message: 'User deleted successfully.'}, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.slice(:id, :name, :email, :password)
    #params.require(:user).permit(:email, :password )
  end
end
