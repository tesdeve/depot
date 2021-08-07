module SessionCounter
  def set_session_counter 
    if session[:counter].nil?
      session[:counter] = 0  
    else
      session[:counter] += 1
    end
  end
end

