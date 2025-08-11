# frozen_string_literal: true

class ListingCardComponent < ViewComponent::Base
  def initialize(listing:, mode: :default, saved_item: nil, transaction: nil, current_user: nil)
    @listing = listing
    @mode = mode # :editable, :saved, :transaction
    @saved_item = saved_item
    @transaction = transaction
    @current_user = current_user
  end
end
