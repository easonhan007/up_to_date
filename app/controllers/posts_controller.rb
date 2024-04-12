class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy add_to_favorites remove_from_favorites rewrite_title]
  before_action :set_openai_key, only: %i[ show rewrite_title]
	skip_before_action :authenticate_user!, only: [:show]
  
  helper_method :openai_key_valid?

  # GET /posts or /posts.json
  def index
    @pagy, @posts = pagy(Post.by_created.all)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @title = @post.title
    @api_call_record = ApiCallRecord.new(user_id: current_user.id, post_id: @post.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts/1/add_to_favorites
  def add_to_favorites
    @favorite = Favorite.new(user_id: current_user.id, post_id: @post.id)
    respond_to do |format|
      if @favorite.save
        format.html { redirect_back(fallback_location: root_path, notice: "Favorited") }
        format.turbo_stream {render turbo_stream: turbo_stream.replace(@post, partial: 'posts/favorites_button', locals: {post: @post, user: current_user})}
      else
        format.html { redirect_back(fallback_location: root_path, notice: 'Failed to add to favorites') }
        format.turbo_stream {render turbo_stream: turbo_stream.replace(@post, partial: 'posts/favorites_button', locals: {post: @post, user: current_user})}
      end #if
    end
  end

  # DELETE /posts/1/remove_from_favorites
  def remove_from_favorites
    @favorite = Favorite.where(user_id: current_user.id, post_id: @post.id).first
    respond_to do |format|
      if @favorite.destroy
        format.html { redirect_back(fallback_location: root_path, notice: "Removed from favorites") }
        format.turbo_stream {render turbo_stream: turbo_stream.replace(@post, partial: 'posts/favorites_button', locals: {post: @post, user: current_user})}
      else
        format.html { redirect_back(fallback_location: root_path, notice: 'Failed to add to favorite') }
        format.turbo_stream {render turbo_stream: turbo_stream.replace(@post, partial: 'posts/favorites_button', locals: {post: @post, user: current_user})}
      end #if
    end
  end


  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def rewrite_title
    if openai_key_valid?(@openai_key)
      @openapi_base_url = Setting.get("openapi_base_url")
      prompt = Setting.get("title_rewrite_prompt")
      @title_rewrite_prompt = prompt.blank? ? 'Rework this sentence to make it more engaging:' : prompt
      AiCompletionJob.perform_later(@post, @openai_key, @openapi_base_url, @title_rewrite_prompt)
      @message = "🎉"
    else
      @message = "😭" 
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_openai_key
      @openai_key = Setting.get('openai_key')
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :from, :crawler_record_id)
    end

    def rewrite_params
      params.require(:post).permit(:id)
    end

    def openai_key_valid?(key)
      (not key.blank?) and (not key.eql?('openai_key'))
    end
end
