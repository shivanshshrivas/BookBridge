class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    # Expecting ransack query hash in params[:q]; store as JSON in query_params
    qp = params[:q].is_a?(ActionController::Parameters) ? params[:q].to_unsafe_h : (params[:q].presence || {})
    @subscription = current_user.subscriptions.build(query_params: qp)
    if @subscription.save
      if request.referer&.include?(listings_path)
        redirect_to listings_path(q: qp), notice: 'Arrival notification set.'
      else
        redirect_to subscriptions_path, notice: 'Subscription created successfully.'
      end
    else
      if request.referer&.include?(listings_path)
        redirect_to listings_path(q: qp), alert: 'Subscription could not be created.'
      else
        redirect_to subscriptions_path, alert: 'Subscription could not be created.'
      end
    end
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    qp = @subscription.query_params
    @subscription.destroy
    if request.referer&.include?(listings_path)
      redirect_to listings_path(q: qp), notice: 'Arrival notification removed.'
    else
      redirect_to subscriptions_path, notice: 'Subscription canceled successfully.'
    end
  end

end
