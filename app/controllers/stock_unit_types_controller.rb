class StockUnitTypesController < ActionController::API
  before_action :authenticate_user!

  def create
    stock_unit_type = StockUnitType.create!(stock_unit_type_params)
    render "stock_unit_types/show.json", locals: { stock_unit_type: stock_unit_type }
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end

  private

  def stock_unit_type_params
    # Have to do some unpleasant looking digging here to allow an array of arrays as a parameter
    sutp = params.require(:stock_unit_type).permit(
      :name
    )
    if params.require(:stock_unit_type).has_key?(:schema)
      sutp[:schema] = params.require(:stock_unit_type).require(:schema)
    end
    sutp
  end

end
