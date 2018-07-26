class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      
      @favorite = Favorite.new
      @favorite_list = current_user.get_favorite_list_from_microposts(@microposts)
    end
  end
  
end
