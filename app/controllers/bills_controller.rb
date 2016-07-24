class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
    @per_person = (@bill.amount / @bill.party_size)
    @per_person = @per_person.round(2)
  end

  def new
    if user_signed_in?
      @user = current_user
      @bill = Bill.new
      @group = Group.find_by(id: params[:group_id])
    else
      @user = current_user
      @bill = Bill.new
    end
  end

  def create
    if user_signed_in?
      @bill = Bill.new(bill_params)
      @group = Group.find(params[:group_id])
      @bill.owner = current_user
      if @group.nil?
        @bill = Bill.new(bill_params)
        @bill.owner = current_user
        if @bill.save
          flash[:success] = "Bill successfully split!"
          redirect_to bill_path(@bill)
        else
          flash[:notice] = "Something Went Wrong"
          redirect_to new_bill_path
        end
      else
        @bill.group = @group
        if @bill.save
          flash[:success] = "Bill successfully split!"
          redirect_to group_path(@bill.group_id)
        else
          flash[:notice] = "Something Went Wrong"
          redirect_to new_bill_path
        end
      end
    else
      @bill = Bill.new(bill_params)
      @bill.owner = current_user
      if @bill.save
        flash[:success] = "Bill successfully split!"
        redirect_to bill_path(@bill)
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
