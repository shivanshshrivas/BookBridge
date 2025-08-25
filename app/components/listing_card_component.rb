# frozen_string_literal: true

class ListingCardComponent < ViewComponent::Base
  def initialize(listing:, mode: :default, saved_item: nil, transaction: nil)
    @listing = listing
    @mode = mode # :editable, :saved, :transaction
    @saved_item = saved_item
    @transaction = transaction
  end

  private

  def transaction_status_color
    case @transaction.status
    when "completed"
      "text-green-600"
    when "in_progress"
      "text-amber-600"
    when "cancelled"
      "text-red-600"
    else
      "text-gray-500"
    end
  end
end
