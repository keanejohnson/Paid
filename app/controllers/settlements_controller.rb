class SettlementsController < ApplicationController
  def create
    @group = Group.find_by(id: params[:group_id])
    @bills = @group.bills.where(settlement_id: nil)
    @settlement = Settlement.new
    @settlement.group = @group
    @settlement.save

    @bills.each do |bill|
      bill.settlement = @settlement
      bill.save
    end

    @settlement.calc_average_payment

    @users = @group.users
    @users.each do |user|
      @settlement_payment = SettlementPayment.create(
        user: user,
        settlement: @settlement
      )
      @settlement_payment.settlement_amount = (@settlement.bills.where(owner: user).sum(:amount) - @settlement.average_payment).round(2)
      if @settlement_payment.settlement_amount < 0
        @settlement_payment.debit = true
      else
        @settlement_payment.debit = false
      end
      @settlement_payment.save
    end
    redirect_to settlement_path(@settlement)
  end

  def show
    @settlement = Settlement.find(params[:id])
    @bills = @settlement.bills
    @settlement_payments = @settlement.settlement_payments
  end
end
