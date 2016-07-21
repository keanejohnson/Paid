class BillsController < ApplicationController
  def show
    @bill = Bill.find(params[:id])
    @per_person = (@bill.amount / @bill.party_size).round(2)
  end

  def new
    @user = current_user
    @bill = Bill.new
  end

  def create
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

  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy
    @user = current_user
    redirect_to user_path(@user)
  end

  protected

  def bill_params
    params.require(:bill).permit(:title, :description, :amount, :party_size)
  end
end
