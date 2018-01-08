module V1
  class MartiansController < ActionController::API
    def index
      return render plain: '' if params[:respond_with_broken_json]
      render json: Martian.all
    end

    def show
      martian = Martian.find(params[:id])
      render json: martian
    end
  end
end
