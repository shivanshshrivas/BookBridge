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

    if current_user && params[:q].present?
      raw_q = params[:q].to_unsafe_h rescue params[:q]
      @existing_subscription = current_user.subscriptions.find_by(query_params: raw_q)
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end
end
