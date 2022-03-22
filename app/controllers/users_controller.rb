class UsersController < ApplicationController #  < ActionController::API

  # skip_before_filter: check_session_and_raise

  # GET /users
  def index
    check_session_and_raise
    @users = User.all
    render json: UsersRepresenter.new(@users).to_json
  end

  # GET /user/:id
  def show
    check_session_and_raise
    check_access
    @user = User.find(params[:id])
    if @user
      render json: UserRepresenter.new(@user).to_json, status: 200
    else
      render json: @user.errors, status: :not_found
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      # binding.pry
      render json: UserRepresenter.new(@user).to_json, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    check_session_and_raise
    check_access
    @user = User.find(params[:id])
    if @user
      @user.update_attributes(:name =>user_params[:name], :password =>user_params[:password])
      render json: {message: 'User successfully updated.'}, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    check_session_and_raise
    check_access
    @user = User.find(params[:id])
    if @user
      @user.destroy
      sign_out
      render json: {message: 'User deleted successfully.'}, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.slice(:id, :name, :email, :password)
  end

  def check_access
    if current_user.id.to_s != params[:id]
      raise ActionController::InvalidAuthenticityToken.new("Invalid access!")
    end
  end
end
