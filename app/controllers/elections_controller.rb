class ElectionsController < ActionController::Base

  layout "application"

  def show
    results = Election.results_for(params[:year], params[:province])
    @year = results[:year]
    @province_name = results[:province_name]

    @results_json = results.to_json

    respond_to do |format|
      format.html
      format.json { render json: @results_json }
    end

  end

end
