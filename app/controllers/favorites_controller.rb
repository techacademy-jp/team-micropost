class FavoritesController < ApplicationController
  def index
  end

  def new
  end

  def create
    
    @fav = Favorite.new(fav_params)
    if @fav.save
      redirect_to :back, flash: {success: "お気に入り登録しました"}
    else
      redirect_to :back, flash: {danger: "お気に入り登録に失敗しました"}
    end
    
  end
  
  def show 
  end

  def destroy
    
    # TODO : エラーハンドリング未実装
    
    @fav = Favorite.find_by(id: params[:id])
    @fav.destroy
    
    #flash.now[:success] = "お気に入りから削除しました。"
    redirect_to :back, flash: {success: "お気に入りから削除しました。"}
  end
  
  private
  def fav_params
    params.require(:favorite).permit(:user_id, :content_id)
  end
end
