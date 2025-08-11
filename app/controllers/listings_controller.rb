class ListingsController < ApplicationController
  def index
    base_scope = Listing.where(status: "Available")
    if current_user&.university.present?
      base_scope = base_scope.where(university: current_user.university)
    end
    @q = base_scope.ransack(params[:q])
    @selected_search = params[:q]
    @selected_input = params.dig(:q, :selected_input) || "title"
    @listings = params[:q].present? ? @q.result(distinct: true) : []
  end

  def show
    @listing = Listing.find(params[:id])
  end
end
