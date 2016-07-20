class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @bills = @user.bills
  end
end
