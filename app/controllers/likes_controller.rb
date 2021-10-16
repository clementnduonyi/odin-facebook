class LikesController < ApplicationController
  

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end


  # POST /likes or /likes.json
  def create
    if params[:like][:user_id].to_i == current_user.id
      Like.create(like_params)
    end
      redirect_to root_url
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    like = Like.find(params[:id])
    if like.user == current_user
        Like.destroy(params[:id])
    end
    redirect_to root_url
  end

  private
  #Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end



  # Only allow a list of trusted parameters through.
  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
