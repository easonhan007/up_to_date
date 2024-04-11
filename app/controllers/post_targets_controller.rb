class PostTargetsController < ApplicationController
  before_action :set_post_target, only: %i[ show edit update destroy ]

  # GET /post_targets or /post_targets.json
  def index
    @post_targets = PostTarget.all
  end

  # GET /post_targets/1 or /post_targets/1.json
  def show
  end

  # GET /post_targets/new
  def new
    @post_target = PostTarget.new
    @post_target.field_mapping = '{
      "post": {
        title: "post.title",
        content: "post.content",
        display_title: "post.slug",
        image: "post.image_url",
      }
    }'
  end

  # GET /post_targets/1/edit
  def edit
  end

  # POST /post_targets or /post_targets.json
  def create
    @post_target = PostTarget.new(post_target_params)

    respond_to do |format|
      if @post_target.save
        format.html { redirect_to post_target_url(@post_target), notice: "Post target was successfully created." }
        format.json { render :show, status: :created, location: @post_target }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_targets/1 or /post_targets/1.json
  def update
    respond_to do |format|
      if @post_target.update(post_target_params)
        format.html { redirect_to post_target_url(@post_target), notice: "Post target was successfully updated." }
        format.json { render :show, status: :ok, location: @post_target }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post_target.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_targets/1 or /post_targets/1.json
  def destroy
    @post_target.destroy!

    respond_to do |format|
      format.html { redirect_to post_targets_url, notice: "Post target was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_target
      @post_target = PostTarget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_target_params
      params.require(:post_target).permit(:api,:headers, :field_mapping, :success_code, :name, :query)
    end
end
