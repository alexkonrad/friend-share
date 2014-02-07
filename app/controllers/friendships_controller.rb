class FriendshipsController < ApplicationController

  def create
    sleep(2)
    Friendship.create!(out_friend_id: params[:id],
      in_friend_id: current_user.id )
      render nothing: true
  end

  def destroy
    sleep(2)
    @friendship = Friendship.find_by_out_friend_id_and_in_friend_id(params[:id], current_user.id)

    @friendship.destroy
    render nothing: true
  end

end
