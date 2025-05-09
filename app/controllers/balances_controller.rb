class BalancesController < ApplicationController
  def show
    balance = Balance.new(params).call

    if balance.nil?
      render json: 0, status: :not_found
    else
      render json: balance, status: :ok
    end
  end
end
