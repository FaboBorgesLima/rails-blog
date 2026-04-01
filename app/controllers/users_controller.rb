class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update logout ]
  before_action :authenticate, only: %i[ edit update logout ]
  before_action :can_edit_user, only: %i[ edit update ]

  # GET /users or /users.json
  def index
    @users = User.all
  end
  
  def new
    # user creation is disabled, only seed users are allowed
    head :not_found
  end

  def login_form
    render :login
  end

  def logout
    logger.info "User #{@auth_user.id} logged out successfully."
    @auth_user.logout!(session)
    redirect_to root_path, notice: "Logged out successfully."
  end

  # POST /users/login
  def login
    user = User.authenticate(params[:email], params[:password])
    if user
      logger.info "User #{user.id} logged in successfully."
      user.login!(session)
      redirect_to root_path, notice: "Logged in successfully."
      return
    end

    flash.now[:alert] = "Invalid email or password."
    render :login, status: :unprocessable_entity
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
    if !@auth_user.can_edit?(@user)
      redirect_to @user, alert: "You don't have permission to edit this user."
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    def can_edit_user
      if !@auth_user.can_edit?(@user)
        redirect_to @user, alert: "You don't have permission to edit this user."
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      permitted = params.require(:user).permit(:name, :email, :password, :password_confirmation, :description, :github_url, :linkedin_url, :linkedin_username)
      if permitted[:password].blank?
        permitted.delete(:password)
        permitted.delete(:password_confirmation)
      end
      permitted
    end
end
