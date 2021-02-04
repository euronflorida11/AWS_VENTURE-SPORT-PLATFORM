class SportsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @sports = Sport.where(is_active: true)
    @sport = Sport.new
  end

  def create
    @sport = Sport.new(sport_params)
    if @sport.save
      redirect_to sports_path, notice: "Vスポーツを作成しました。"
    else
      @sports = Sport.all
      render "index"
    end
  end

  def show
    @sports = Sport.where(is_active: true)
    @sport = Sport.find(params[:id])
  end

  def edit
    @sport = Sport.find(params[:id])
  end

  def update
    @sport = Sport.find(params[:id])
    if @sport.update(sport_params)
      redirect_to sports_path, notice: "Vスポーツを更新しました。"
    else
      render "edit"
    end
  end

  private

  def sport_params
    params.require(:sport).permit(:image, :user_id, :name, :is_active, :introduction)
  end
end