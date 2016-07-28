class UserGroupsController < ApplicationController
  def new
    @users = User.all
    @group = Group.find(params[:group_id])
    @user_group = UserGroup.new
  end

  def create
    @group = Group.find(params[:group_id])
    @user_group = UserGroup.new
    @user_group.user_id = params[:user_group][:user_id]
    @user_group.group_id = params[:group_id]

    if @user_group.save
      flash[:success] = "Group Successfully Updated"
      redirect_to group_path(@group)
    else
      render :edit
    end
  end
end
