class API::PerformancesController < API::BaseController
  def index
    performances = Performance.all
    render json: PerformanceSerializer.new(performances)
  end
end
