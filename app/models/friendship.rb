class Friendship < ActiveRecord::Base
  attr_accessible :out_friend_id, :in_friend_id

  belongs_to :out_friend,
  class_name: "User",
  foreign_key: :out_friend_id

  belongs_to :in_friend,
  class_name: "User",
  foreign_key: :in_friend_id

  def self.can_friend?(out_friend_id, in_friend_id)
    (out_friend_id != in_friend_id) && !exists?(out_friend_id: out_friend_id, in_friend_id: in_friend_id) && !exists?(out_friend_id: in_friend_id, in_friend_id: out_friend_id)
  end

  def self.can_unfriend?(out_friend_id, in_friend_id)
    (out_friend_id != in_friend_id) && (exists?(out_friend_id: out_friend_id, in_friend_id: in_friend_id) || exists?(out_friend_id: in_friend_id, in_friend_id: out_friend_id))
  end
end