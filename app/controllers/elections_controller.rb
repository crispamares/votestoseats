class ElectionsController < ActionController::Base

  def show
    results = Election.results_for(params[:year], params[:province])
    @year = results[:year]
    @province_name = results[:province_name]

    respond_to do |format|
      format.html
      format.json { render json: results.to_json }
    end

  end

end
