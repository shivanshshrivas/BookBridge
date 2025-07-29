class ListingsController < ApplicationController
  def index
    @q = Listing.ransack(params[:q])
    @listings = @q.result
  end

  def show
  end
end
