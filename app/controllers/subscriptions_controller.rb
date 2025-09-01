class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    # Expecting ransack query hash in params[:q]; store as JSON in query_params
    @subscription = current_user.subscriptions.build(query_params: subscription_params)
    if @subscription.save
      redirect_back(fallback_location: listings_path(q: subscription_params), notice: "Arrival notification set.")
    else
      redirect_back(fallback_location: listings_path(q: subscription_params), alert: "Subscription could not be created.")
    end
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    qp = @subscription.query_params
    @subscription.destroy
    redirect_back(fallback_location: listings_path(q: qp), notice: "Arrival notification removed.")
  end

  private

  def subscription_params
    params.require(:q).permit(:title_cont, :authors_cont, :isbn_cont, :course_number_cont, :listing_type_eq, :sorts, :selected_input)
  rescue ActionController::ParameterMissing
    {}
  end
end
