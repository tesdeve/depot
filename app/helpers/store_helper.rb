module StoreHelper
  def date_time
    DateTime.current.strftime("%d-%b-%y   %H:%M")
  end

  def show_visits_greater_than_five 
    if session[:counter] > 5
      pluralize(session[:counter], "visit") + "to this page"
    end 
  end
end


