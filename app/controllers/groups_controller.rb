class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @user = current_user
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "New Group Created"
      redirect_to groups_path
    else
      flash[:notice] = "Something Went Wrong"
      redirect_to new_group_path
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  protected

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
