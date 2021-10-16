class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:show, :index]
    # before_action :set_request
    
    
    def index
        @users = User.all
        @requests = Request.all
        @requests.each do |request|
            request
        end
    end

    
    def show
        @users = User.all
        if params[:id]
            @user = User.find(params[:id])
        else
            @user = current_user
        end
        @requests = current_user.recieved_requests.all
        @fans = current_user.fans.all
        @posts = Post.all
        
    end

    def friends
        @fans = current_user.fans.all
        # @post = @fans.posts.all
    end

    
end
