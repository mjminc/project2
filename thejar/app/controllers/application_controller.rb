class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_authenticated?
  	redirect_to root_path unless current_user
  end

  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  # time calculations
    def get_duration(start_d, end_d)
    start_date = start_d.in_time_zone("Pacific Time (US & Canada)")
    end_date = end_d.in_time_zone("Pacific Time (US & Canada)")
    return duration = (end_date - start_date).to_i / 1.day
  end

  def get_pct_complete(start_d, end_d)
    start_date = start_d.in_time_zone("Pacific Time (US & Canada)")
    end_date = end_d.in_time_zone("Pacific Time (US & Canada)")
    today = DateTime.now.in_time_zone("Pacific Time (US & Canada)")
    return pct_complete = (((today - start_date).to_f / (end_date - start_date).to_f) * 100).round
  end

  def get_days_left(start_d, end_d)
    start_date = start_d.in_time_zone("Pacific Time (US & Canada)")
    end_date = end_d.in_time_zone("Pacific Time (US & Canada)")
    today = DateTime.now.in_time_zone("Pacific Time (US & Canada)")
    return days_left = (end_date - start_date).to_i / 1.day
  end

end
