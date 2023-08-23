class UsersController < ApplicationController

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana))
    @user.save
  end

end
