class ListingsController < ApplicationController
  def index
    @q = Listing.ransack(params[:q])
    @listings = params[:q].present? ? @q.result(distinct: true) : []
  end

  def show
    @listing = Listing.find(params[:id])
  end
end
