class SpeciesController < ApplicationController
  PER = 50

  def index
    @q = Species.page(params[:page]).per(PER).search(search_params)
    @species = @q.result(distinct: true)
  end

  def show
    @species = Species.find(params[:id])
  end

  def search_params
    params.fetch(:q, {}).permit(:scientific_name_cont, :japanese_name_cont, :chinese_name_cont, :korean_name_cont, :english_name_cont)
  end
end
