class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.create(username: params[:username], password: params[:password])
    if @user.valid?
      render json: {token: issue_token({id:@user.id}) }
    else
      render json: {error: 'Username taken'}

    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json:{ token: issue_token({id:user.id})}
    else
      render json: { error: "Cannot find or authenticate user"}
    end
  end

  def get_current_user
    if current_user
      render json: {username:current_user.username, id: current_user.id, songs: current_user.songs}
    else
      render json: {error: 'no user'}
    end
  end

  def song_list
    if current_user
      render json: current_user.songs
    end


  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
