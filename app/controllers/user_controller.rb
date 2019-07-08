class UserController < ApplicationController
  

  def index
    @user = User.search(params[:search],[current_user.id])
  
  end

  def show
    @user = current_user
  end

   def update
      @user = current_user
      # @user.photo.attach(params[:user][:photo])
      
      if @user.photo.attach(params[:user][:photo]) 
        redirect_to root_path
      end
      # else
      #    render :edit  
      # end
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
