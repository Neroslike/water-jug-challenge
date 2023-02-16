class WaterjugController < ApplicationController
  def result
    x = params[:x].to_i
    y = params[:y].to_i
    z = params[:z].to_i
    algorithm = JugAlgorithm.new(x, y, z)
    result = algorithm.calculate
    render json: {result: result}
  end
end
