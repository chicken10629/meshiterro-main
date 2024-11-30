class Admin::DashboardsController < ApplicationController
  layout 'admin' #使うレイアウトを指定
  before_action :authenticate_admin!
  def index
    @users = User.all
  end
end
