# frozen_string_literal: true

class ListingCardComponent < ViewComponent::Base
  def initialize(listing:, mode: :default, saved_item: nil)
    @listing = listing
    @mode = mode # :editable, :saved
    @saved_item = saved_item
  end
end
