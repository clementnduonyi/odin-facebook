module UserHelper

    
    def all_friend_requests
        requests = Request.includes(:sender).where("reciever_id = ?", current_user.id)
        requests
    end

    

    def remove
        @user = User.find(params[:user_id])
        @user.destroy
    end

end
