class SpeciesController < ApplicationController
  PER = 50

  def index
    @q = Species.page(params[:page]).per(PER).search(search_params)
    @species = @q.result(distinct: true)
  end

  def show
    @species = Species.find(params[:id])
  end

  def new
    @species = Species.new
  end

  def create
    @species = Species.new(species_params)
    if @species.save
      redirect_to @species, notice: '作成しました'
    else
      render :new
    end
  end

  def edit
    @species = Species.find(params[:id])
  end

  def update
    @species = Species.find(params[:id])
    if @species.update(species_params)
      redirect_to @species, notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @species = Species.find(params[:id])
    @species.destroy!
    redirect_to species_path, notice: '削除しました'
  end

  def species_params
    params.require(:species).permit(
        :scientific_name, :japanese_name,
        :chinese_name, :korean_name,
        :english_name
    )
  end

  def search_params
    params.fetch(:q, {}).permit(:scientific_name_cont, :japanese_name_cont, :chinese_name_cont, :korean_name_cont, :english_name_cont)
  end
end
