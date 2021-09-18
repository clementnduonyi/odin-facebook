class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:show, :index]
    
    def index
        @users = User.all
        
    end

    
    def show
        if params[:id]
            @user = User.find(params[:id])
        else
            @user = current_user
        end
        @requests = current_user.recieved_requests.all
        @fans = current_user.fans.all
    end

end
