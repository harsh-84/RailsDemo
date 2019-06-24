class UserController < ApplicationController
  

  # def index
  #   @user = User.all
  # end

  def show
    @user = current_user
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(params[:user])
  #   if @user.save
  #     session[:user_id] = @user.id
  #     flash[:notice] = "Thanks for signing up!! YOur are now logged in."
  #     redirect_to root_url
  #   else
  #     render :action => 'new'      
  #   end

  # end

end
