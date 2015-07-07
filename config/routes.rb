Rails.application.routes.draw do
  root 'home#index'
  get 'table-of-dates' => 'table_of_dates#index', as: :table_of_dates
  get 'date/:year.:month.:day' => 'date#view'
end
