class ListingsController < ApplicationController
  def index
    @q = Listing.ransack(params[:q])
    @selected_search = params[:q]
    @selected_input = params.dig(:q, :selected_input) || "title"
    @listings = params[:q].present? ? @q.result(distinct: true) : []
  end

  def show
    @listing = Listing.find(params[:id])
  end
end
