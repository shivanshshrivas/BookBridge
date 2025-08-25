# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :load_threads, only: [:index, :show]

  def index
  end

  # GET /messages/thread/:listing_id/:user_id
  def show
    @listing = Listing.find(params[:listing_id])
    @other = User.find(params[:user_id])

    if @other.id == current_user.id
      redirect_to messages_path, alert: "You can’t message yourself." and return
    end

    @messages = Message
      .between(current_user.id, @other.id, @listing.id)
      .includes(:messageable)
  end

  # POST /messages
  # params: listing_id, receiver_id, kind: "text"|"transaction"
  # text:   content
  # txn:    transaction: { start_date, end_date }
  def create
    listing = Listing.find(params[:listing_id])
    receiver = User.find(params[:receiver_id])

    case params[:kind]
    when "text"
      tm = TextMessage.create!(content: params[:content].to_s.strip)
      Message.create!(listing:, sender: current_user, receiver:, messageable: tm)
    when "transaction"
      lender = listing.user
      borrower = (current_user == lender) ? receiver : current_user

      attrs = {listing:, lender:, borrower:, status: :pending}
      if listing.listing_type == "Lend"
        attrs[:end_date] = params.dig(:transaction, :end_date)
      end

      txn = Transaction.create!(attrs)
      Message.create!(listing:, sender: current_user, receiver:, messageable: txn)
    else
      redirect_back fallback_location: messages_path, alert: "Unknown kind" and return
    end

    redirect_to message_thread_path(listing_id: listing.id, user_id: receiver.id)
  end

  private

  def load_threads
    base = Message.where(sender: current_user).or(Message.where(receiver: current_user))
    @threads = base
      .select("DISTINCT ON (listing_id, LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id)) messages.*")
      .order(Arel.sql(
        "listing_id, LEAST(sender_id, receiver_id), GREATEST(sender_id, receiver_id), created_at DESC"
      ))
      .includes(:listing, :sender, :receiver, :messageable)
  end
end
