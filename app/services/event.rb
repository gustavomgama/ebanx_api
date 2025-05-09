class Event
  def initialize(params)
    @type = params[:type]
    @amount = params[:amount]
    @origin = params[:origin]
    @destination = params[:destination]
  end

  def call
    case @type
    when "deposit"
      deposit
    when "withdraw"
      withdraw
    when "transfer"
      transfer
    end
  end

  private

  def deposit
    balance = Rails.cache.read(destination) || 0
    balance += @amount

    Rails.cache.write(destination, balance)

    {
      "destination" => {
        "id" => @destination,
        "balance" => balance
      }
    }
  end

  def withdraw
    balance = Rails.cache.read(origin)
    return nil if balance.nil?

    balance -= @amount

    Rails.cache.write(origin, balance)

    {
      "origin" => {
        "id" => @origin,
        "balance" => balance
      }
    }
  end

  def transfer
    origin_balance = Rails.cache.read(origin)
    return nil if origin_balance.nil?

    destination_balance = Rails.cache.read(destination) || 0

    origin_balance -= @amount
    destination_balance += @amount

    Rails.cache.write(origin, origin_balance)
    Rails.cache.write(destination, destination_balance)

    {
      "origin" => {
        "id" => @origin,
        "balance" => origin_balance
      },
      "destination" => {
        "id" => @destination,
        "balance" => destination_balance
      }
    }
  end

  def origin
    "account:#{@origin}"
  end

  def destination
    "account:#{@destination}"
  end
end
