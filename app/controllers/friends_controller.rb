class FriendsController < ApplicationController
  before_action :authenticate_user!
 
    
  def create
    request = Request.find_by(id: params[:request])
    request.accept
    redirect_to request.referrer
  end

  def destroy
    friend = Friend.where('user_id = ? AND
                                    friend_id = ?',
                                    current_user.id, params[:id])[0]
    if friend.destroy
      flash[:notice] = "Action completed"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Action Unauthorized"
      redirect_to user_path(current_user)
    end
  end

end
