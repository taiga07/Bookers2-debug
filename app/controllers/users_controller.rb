class UsersController < ApplicationController

  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @currentRoomUser = RoomUser.where(user_id: current_user.id)
    #current_userが既にルームに参加しているか判断
    @receiveUser = RoomUser.where(user_id: @user.id)
    #他の@userがルームに参加しているか判断
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user

    unless @user.id == current_user.id  #current_userと@userが一致していなければ
      @currentRoomUser.each do |cu|  #current_userが参加しているルームを取り出す
        @receiveUser.each do |u|  #@userが参加しているルームを取り出す
          if cu.room_id == u.room_id  #current_userと@userのルームが同じか判断(既にルームが作られているか)
            @haveRoom = true  #falseの時(同じじゃない時)の条件を記述するために変数に代入
            @roomId = cu.room_id  #ルームが共通しているcurrent_userと@userに対して変数を指定
          end
        end
      end
      unless @haveroom  #ルームが同じじゃなければ
        @room = Room.new  #新しいインスタンスを生成
        @roomuser = RoomUser.new  #新しいインスタンスを生成
      end
    end

  end


  def index
    @users = User.all
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
    if @user==current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def follows
    @user = User.find(params[:id])
    @follows = @user.following_user
  end

  def followers
    @user = User.find(params[:id])
    @followed = @user.follower_user
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
