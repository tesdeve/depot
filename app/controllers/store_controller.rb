class StoreController < ApplicationController
  include SessionCounter
  before_action :set_session_counter, only: [:index]
  
  def index     
    @products = Product.order(:title)
  end
end
