class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy] 
  before_action :get_post
  
  # GET /comments or /comments.json
  def index
    @comments = @post.comments.all
    #@comment = Comment.new
    @comment = @post.comments.new
    if params[:id]
        @user = User.find(params[:id])
    else
        @user = current_user
    end
  end

  # GET /comments/1 or /posts/1.json
  def show
    @comment = @post.comments.find(params[:id])
  end

 
  # GET /comments/new
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(parent_id: params[:parent_id])
    
    #@comment = Comment.new
    
  end

  # GET /comments/1/edit
  def edit
    @comment = @post.comments.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_comments_path, notice: "Comment was successfully created." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_comments_path, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
      @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body, :post_id, :parent_id)
  end

  def get_post
    @post = Post.find(params[:post_id])
  end

  

end
