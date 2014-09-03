class SitesController < ApplicationController
  def index
    @user = current_user
  end

  def about
    @user = current_user
  end

  def contact
    @user = current_user
  end
end
