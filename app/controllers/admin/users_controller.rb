class Admin::UsersController < ApplicationController

  before_action :require_admin

  def show
    if current_user.platform_admin?
      @stores = Store.all
    else
      @stores = current_user.stores
    end 
    @pending_stores = Store.where(status: "pending")
  end
end
