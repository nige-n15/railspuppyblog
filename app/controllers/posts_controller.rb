class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update save_post_view destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @post
      }
      format.text {
        render plain: @post.title
      }
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.validate
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      flash[:warning] = "Some required information was missing or incorrect."
      render :new
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
      @post.main_image.attach(params[:main_image])
      @post.validate
      if @post.update!(post_params)
        respond_to do |format|
          format.html { redirect_to @post, notice: "Post was successfully updated." }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  def save_post_view
    # increment view count for post
    @post.increment(:views,1).save
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :summary, :category_id, :body, :active, :main_image)
    end
end
