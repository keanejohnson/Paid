class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
  end

  def new
    @user = current_user
    @bill = Bill.new
    @group = Group.find_by(id: params[:group_id])
  end

  def create
    if user_signed_in?
      @bill = Bill.new(bill_params)
      @group = Group.find(params[:group_id])
      @bill.owner = current_user
      @bill.group = @group
      if @bill.save
        flash[:success] = "Bill successfully split!"
        redirect_to group_path(@bill.group_id)
      else
        flash[:notice] = "Something Went Wrong"
        redirect_to new_bill_path
      end
    end
  end

  def destroy
    if user_signed_in?
      @bill = Bill.find(params[:id])
      @bill.destroy
      @user = current_user
      redirect_to user_path(@user)
    else
      @bill = Bill.find(params[:id])
      @bill.destroy
      redirect_to root_path
    end
  end

  protected

  def bill_params
    params.require(:bill).permit(:title, :description, :amount, :party_size)
  end
end
