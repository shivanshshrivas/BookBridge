class MyListingsController < ApplicationController
  def index
    @listings = current_user.listings
  end

  def new
    @listing = current_user.listings.build
  end

  def create
    @listing = current_user.listings.build(listing_params)
    @listing.university = current_user.university
    @listing.price = (params[:listing][:listing_type] == "sell") ? params[:listing][:price] : nil
    if @listing.save
      redirect_to my_listings_path, notice: "Listing created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def listing_params
    params.expect(listing: [:isbn, :title, :authors, :edition, :course_number, :description, :listing_type, :price, images: []])
  end
end
