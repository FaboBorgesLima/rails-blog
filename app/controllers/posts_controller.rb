class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ new create ]
  before_action :authenticate, only: %i[ edit update destroy create new]
  before_action :can_edit_post, only: %i[ edit update destroy ]

  # GET /
  def index
    query = Post.all
    query = query.where(user_id: params[:user_id]) if params[:user_id].present?
    @posts = query.limit(10).offset(params[:offset].to_i * 10 || 0)
  end

  # GET /users/1/posts/1 or /users/1/posts/1.json
  def show
    user = @auth_user
    logger.debug "Current user: #{user.inspect}"
  end

  # GET /users/1/posts/new
  def new
    @post = Post.new(user_id: params[:user_id])
  end

  # GET /users/1/posts/1/edit
  def edit
  end

  # POST /users/1/posts or /users/1/posts.json
  def create
    begin
      @post = Post.create_with_user(post_params, @auth_user)
    rescue => e
      redirect_to root_path, alert: e.message and return
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_path(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1/posts/1 or /users/1/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_path(@post), notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/posts/1 or /users/1/posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to user_posts_path(@post.user), notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def can_edit_post
    unless @post.can_edit?(@auth_user)
      redirect_to root_path, alert: "You are not authorized to edit this post."
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.expect(post: [ :title, :description, :user_id, :content ])
  end
end
