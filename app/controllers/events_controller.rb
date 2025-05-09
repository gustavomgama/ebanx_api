class EventsController < ApplicationController
  def create
    result = Event.new(params).call

    if result.nil?
      render json: 0, status: :not_found
    else
      render json: result, status: :created
    end
  end
end
