class RoomsController < ApplicationController

  def create
    @room = Room.create
    @joincurrentuser = RoomUser.create(user_id: current_user.id, room_id: @room.id)
    @joinuser = RoomUser.create(join_room_params)
    redirect_to room_path(@room.id)
  end




  def show
    @room = Room.find(params[:id])
    if RoomUser.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @roomusers = @room.room_users
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def join_room_params
    params.require(:room_user).permit(:user_id, :room_id).merge(room_id: @room.id)
  end






end
