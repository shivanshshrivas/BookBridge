class SavedItemsController < ApplicationController
  before_action :set_listing, only: [:create, :destroy]

  def create
    current_user.saved_items.create(listing: @listing)
    redirect_back fallback_location: root_path, notice: "Listing saved successfully."
  end

  def destroy
    current_user.saved_items.find_by(listing: @listing)&.destroy
    redirect_back fallback_location: root_path, notice: "Listing removed from saved items."
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end
end
