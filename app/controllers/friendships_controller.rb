class FriendshipsController < ApplicationController

  def create
    Friendship.create!(out_friend_id: params[:id],
      in_friend_id: current_user.id )
    redirect_to users_url
  end

end
