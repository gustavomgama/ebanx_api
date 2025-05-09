class Balance
  def initialize(params)
    @account_id = params[:account_id]
  end

  def call
    Rails.cache.read(account)
  end

  private

  def account
    "account:#{@account_id}"
  end
end
