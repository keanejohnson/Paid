class GroupsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @groups = @user.groups
  end

  def new
    @user = current_user
    @group = Group.new
  end

  def create
    @user = current_user
    @group = Group.new(group_params)
    @group.users << @user
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
    @total = 0
    @bills.each do |bill|
      @total += bill.amount
    end
    @per_person = (@total / @group.size).round(2)
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
