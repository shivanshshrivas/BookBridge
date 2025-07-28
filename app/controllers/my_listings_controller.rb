class MyListingsController < ApplicationController
  before_action :authenticate_user!

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
      redirect_to my_listings_path, notice: 'Listing created successfully.'
    else
      render :new,  status: :unprocessable_entity
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
