# app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :update]
  before_action :authorize_participation!, only: [:show, :update]

  def index
    @transactions = Transaction
      .where("lender_id = :id OR borrower_id = :id", id: current_user.id)
      .includes(:listing)
      .order(updated_at: :desc)
  end

  def show
    # @transaction is already set by before_action
  end

  # PATCH /transactions/:id
  # params: { mark: "got_the_book" } or { transaction: { status, start_date, end_date } }
  def update
    if params[:mark] == "got_the_book"
      if @transaction.listing.listing_type == "Lend"
        @transaction.start_date = Time.zone.today
        @transaction.status = :in_progress
      else # sell
        @transaction.status = :completed
      end
    else
      @transaction.assign_attributes(transaction_params)
      # Auto-set start date when moving a lend to in_progress the first time
      if @transaction.listing.listing_type == "Lend" && @transaction.status.to_s == "in_progress" && @transaction.start_date.blank?
        @transaction.start_date = Time.zone.today
      end
    end

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transaction_path(@transaction), notice: "Transaction updated." }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def authorize_participation!
    allowed = [@transaction.lender_id, @transaction.borrower_id].include?(current_user.id)
    head :forbidden unless allowed
  end

  def transaction_params
    params.fetch(:transaction, {}).permit(:status, :start_date, :end_date)
  end
end
