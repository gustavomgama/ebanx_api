class ResetController < ApplicationController
  def create
    Rails.cache.clear

    render json: "OK", status: :ok
  end
end
