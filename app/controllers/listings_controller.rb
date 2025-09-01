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
      @existing_subscription = current_user.subscriptions.find_by(query_params: search_params)
    end
  end

  private

  def search_params
    params.require(:q).permit(:title_cont, :authors_cont, :isbn_cont, :course_number_cont, :listing_type_eq, :sorts, :selected_input)
  rescue ActionController::ParameterMissing
    {}
  end

  def show
    @listing = Listing.find(params[:id])
  end
end
