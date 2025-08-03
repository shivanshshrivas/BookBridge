class MyListingsController < ApplicationController
  before_action :set_listing, only: %i[edit update destroy]

  def index
    @listings = current_user.listings
  end

  def new
    @listing = current_user.listings.build
  end

  def create
    @listing = current_user.listings.build(listing_params)
    @listing.university = current_user.university
    if @listing.save
      redirect_to my_listings_path, notice: "Listing created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to my_listings_path, notice: "Listing updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.destroy
    redirect_to my_listings_path, notice: "Listing deleted successfully."
  end

  private

  def set_listing
    @listing = current_user.listings.find(params[:id])
  end

  def listing_params
    params.expect(listing: [:isbn, :title, :authors, :status, :edition, :course_number, :description, :listing_type, :price, images: []])
  end
end
