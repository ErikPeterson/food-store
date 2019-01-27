class StockUnitTypesController < ApplicationController
  before_action :authenticate_user!

  def create
    stock_unit_type = StockUnitType.create!(stock_unit_type_params)
    render "stock_unit_types/show.json", locals: { stock_unit_type: stock_unit_type }
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end

  def get
    stock_unit_type = StockUnitType.find(params[:id])
    render "stock_unit_types/show.json", locals: { stock_unit_type: stock_unit_type }
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message }, status: 404
  end

  def index
    sort, page, per_page = validate_pagination_params!
    stock_unit_types = StockUnitType.all
      .order(created_at: sort).paginate(per_page: per_page, page: page)
    render "stock_unit_types/index.json", locals: {
      page: page,
      per_page: per_page,
      sort: sort,
      stock_unit_types: stock_unit_types
    }
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
