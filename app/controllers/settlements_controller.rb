class SettlementsController < ApplicationController
  def create
    @group = Group.find_by(id: params[:group_id])

    # get bills where settlement does not exist
    @bills = @group.bills.where(settlement_id: nil)

    # create new settlement with group id
    @settlement = Settlement.new
    @settlement.group = @group

    # save the settlement
    @settlement.save

    # set the settlement_id of each bill in @bills to our newly created settlement
    @bills.each do |bill|
      bill.settlement = @settlement
      bill.save
    end

    # calculate average payment for settlement (from @settlement.bills)
    @settlement.calc_average_payment

    @users = @group.users
    @users.each do |user|
      @settlement_payment = SettlementPayment.create(user: user, settlement: @settlement)
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

  def index
    @group = Group.find_by(params[:id])
    @settlements =@group.settlements
  end
end
