class ListingsController < ApplicationController
  def index
    @q = Listing.ransack(params[:q])
    @listings = @q.result(distinct: true)
  end

  def show
  end
end
