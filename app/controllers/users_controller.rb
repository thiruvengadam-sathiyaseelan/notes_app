class UsersController < ApplicationController

  before_filter :check_session_and_raise, only: [:show, :destroy, :update]
  before_filter :check_access, only: [:show, :destroy, :update]
  before_filter :set_user, only: [:show, :destroy, :update]

  def index
    @users = User.all
    render json: UsersRepresenter.new(@users).to_json
  end

  def show
    if @user.present?
      render json: UserRepresenter.new(@user).to_json, status: 200
    else
      binding.pry
      render json: @user.errors, status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # binding.pry
      render json: UserRepresenter.new(@user).to_json, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.present?
      @user.update_attributes(name: user_params[:name], password: user_params[:password])
      render json: {message: I18n.t(:updated, scope: [:user])}, status: 200
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.present?
      sign_out
      @user.destroy
      render json: {message: I18n.t(:deleted, scope: [:user])}, status: 200
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
      raise ActionController::InvalidAuthenticityToken.new(I18n.t(:invalid_access, scope: [:user]))
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
