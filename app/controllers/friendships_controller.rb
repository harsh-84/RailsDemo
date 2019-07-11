class FriendshipsController < ApplicationController
  # before_action :set_friendship, only: [:show, :edit, :update, :destroy]
 def accept_request
    status = Friendship.statuses["accept"]
 
    friendship_request = current_user.friendships.find_by_friend_id(params[:friendship_id]) || current_user.inverse_friendships.find_by_user_id(params[:friendship_id]) 
    if friendship_request.update(status: status)
      flash[:notice] = "Friendship accept successfully"
      redirect_to new_friendship_path
    else
      flash[:alert] = "something went wrong"
    end
  end

  def contacts_callback
    @contacts = request.env['omnicontacts.contacts']
    # puts "List of contacts of #{@user[:name]} obtained from #{params[:importer]}:"
    if @contacts.present?
      @contacts.each do |contact|
        #contact = current_user.contacts.find_or_create_by(email: contact[:email])
        # #User.invite!({email:  contact[:email]}, current_user )
        InvitaionMailerJob.perform_later(contact,current_user)
      end
    end
  end
  # def invite_user
  #   current_user.contacts.each do |contact|
  #     InvitaionMailerJob.perform_later(contact.email)
  #   end
  # end

  def friend_list
    @friends = current_user.friendships.accept.map{|fr| fr.friend } + current_user.inverse_friendships.accept.map{|fr| fr.user}

    @friends.uniq!
  end
 
  def index
    @users = User.all
    @inverse_friendship = current_user.inverse_friendships.pending.map{|fr| fr.user}
  end


  def show
  end

  
  def new
    @friendship = Friendship.new
    @user = User.all_except(current_user)

  end

 
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create

    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])

    if @friendship.save
      flash[:notice] = "Added friend"
      redirect_to  new_friendship_path
    else
      flash[:error] = "Unable to add friend"
      redirect_to  new_friendship_path
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  # def update
  #   respond_to do |format|
  #     if @friendship.update(friendship_params)
  #       format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @friendship }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @friendship.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = current_user.friendships.find_by_friend_id(params[:id]) || current_user.inverse_friendships.find_by_user_id(params[:id])
    # @friendship = current_user.friendships.find_by_friend_id(params[:id])
    # @friendship = Friendship.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship"
    redirect_to  new_friendship_path
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_friendship
    #   @friendship = Friendship.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id)
    end
end
