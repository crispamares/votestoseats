class ElectionsController < ActionController::Base

  layout "application"

  def show
    results = Election.results(params[:year])

    @results_json = results.to_json
    @year = results[:year]
    @years = Election.all.pluck(:election_day).sort_by{ |y| y}.reverse.map!{|y| y.strftime("%Y")}

    respond_to do |format|
      format.html
      format.json { render json: @results_json }
    end

  end

  def show_province
    results = Election.results_for(params[:year], params[:province])

    @results_json = results.to_json
    @year = results[:year]
    @province_name = results[:province_name]
    @province_id = params[:province]

    #@provinces = Province.all.pluck(:id, :name)
    @provinces = Province.all
    @years = Election.all.pluck(:election_day).sort_by{ |y| y}.reverse.map!{|y| y.strftime("%Y")}

    respond_to do |format|
      format.html
      format.json { render json: @results_json }
    end

  end

end
