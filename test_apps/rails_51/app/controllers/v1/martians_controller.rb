module V1
  class MartiansController < ActionController::API
    def index
      render json: Martian.all
    end

    def show
      martian = Martian.find(params[:id])
      render json: martian
    end
  end
end
