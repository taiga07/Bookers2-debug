class Room < ApplicationRecord

  has_many :room_users
  # UsersテーブルとRoomsテーブルは多対多の関係
  # そのため、中間テーブルとしてroom_usersテーブルをおき、その情報を管理します。

  has_many :messages
  # またRoomsでは、複数（2人）のユーザーが複数のメッセージを送る多対多の関係なので、
  # これも中間テーブルとしてMessagesテーブルをおき、その情報を管理します。

end
