module StoreHelper
  def date_time
    DateTime.current.strftime("%d-%b-%y   %H:%M")
  end
end


