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
    @bills = @group.bills
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:success] = "Group Successfully Updated"
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end

  protected

  def group_params
    params.require(:group).permit(:name, :description, :size)
  end
end
