class StockUnitsController < ActionController::API
  before_action :authenticate_user!

  def create
    stock_unit = StockUnit.new(stock_unit_params)
    stock_unit.owner ||= current_user
    stock_unit.save!
    render "stock_units/show.json", locals: { stock_unit: stock_unit }
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end

  def stock_unit_params
    params.permit(
      :owner_id,
      :mass_in_grams,
      :expiration_date,
      :description,
      :stock_unit_type_name,
      :stock_unit_type_id,
      :unit_attributes => {}
    )
  end
end
