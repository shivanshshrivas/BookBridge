class ListingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @q = Listing.ransack(params[:q])
    @listings = @q.result
  end

  def show
  end
end
