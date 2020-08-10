class UsersController < ApplicationController
  include SessionsHelper

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, :logged_in_user, only: [:index, :edit, :update, :destroy, :show]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :correct_group, only: [:create]
  before_action :non_change_group, only: [:edit, :update]
  attr_accessor :name

  # GET /users
  # GET /users.json
  def index
    @users = User.where(group_id: current_user.group_id).paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
     @items = @user.items.where(is_borrow: true).paginate(page: params[:page])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(
      name: params[:user][:name],
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation],
      group_id: Group.find_by(name: params[:user][:group])&.id
    )

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
        # redirect_back_or @user
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :group_id)
    end

    def current_user?(user)
        user == current_user
    end
    # beforeアクション

   # ログイン済みユーザーかどうか確認
   def logged_in_user
     unless logged_in?
       store_location
       flash[:danger] = "Please log in."
       redirect_to login_url
     end
   end

   # 正しいユーザーかどうか確認
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def correct_group
      group = Group.find_by(name: params[:user][:group])
      unless group && group.authenticate(params[:user][:group_password])
        redirect_to signup_url
      end
    end

    def non_change_group
      redirect_to(root_url) if params[:group_id] || params[:group_name] || params[:group_password]
    end
end
