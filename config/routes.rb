Rails.application.routes.draw do
  get "/balance", to: "balances#show"
  post "/event", to: "events#create"
  post "/reset", to: "reset#create"
end
