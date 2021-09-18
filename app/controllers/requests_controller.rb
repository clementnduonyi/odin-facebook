class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, except: :create

  def create
    request = Request.create(sender_id: current_user.id, reciever_id: params[:reciever_id])
    if request.save
      flash[:notice] = "Your friend request is waiting!"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Something went wrong! #{request.errors.full_messages.join(", ")}"
      redirect_to users_path
    end
  end

  def confirm
    if @request.reciever_id == current_user.id
      Friend.create(friend: @request.sender, user: @request.reciever)
      @request.sender.fans << @request.reciever 
      @request.destroy
      flash[:notice] = "You and #{ @request.sender.firstname } are now friends!"
      redirect_to user_path(current_user)
      
    else
      flash[:alert] = "Not authorized!"
    end
   
  end


  def declined
    if @request.reciever == current_user
      @request.destroy
      flash[:notice] = "Request declined succesfully!"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "Operation denied"
      redirect_to root_url
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end
end

