class StockUnitsController < ApplicationController
  before_action :authenticate_user!

  def index
    sort, page, per_page = validate_pagination_params!
    stock_units = StockUnit.where(owner_id: current_user.id)
      .order(created_at: sort).paginate(per_page: per_page, page: page)
    render "stock_units/index.json", locals: { page: page, per_page: per_page, sort: sort, stock_units: stock_units }
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end

  def create
    stock_unit = StockUnit.new(stock_unit_params)
    stock_unit.owner ||= current_user
    stock_unit.save!
    render "stock_units/show.json", locals: { stock_unit: stock_unit }
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end

  def show
    stock_unit = StockUnit.find(params[:id])
    if stock_unit.owner_id == current_user.id
      render 'stock_units/show.json', locals: { stock_unit: stock_unit }
    else
      render body: nil, status: 403
    end
  rescue ActiveRecord::RecordNotFound => e
    render body: nil, status: 404
  end

  def update
    stock_unit = StockUnit.find(params[:id])
    if stock_unit.owner_id == current_user.id
      stock_unit.update!(stock_unit_params)
      render 'stock_units/show.json', locals: { stock_unit: stock_unit }
    else
      render body: nil, status: 403
    end
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end

  def destroy
    stock_unit = StockUnit.find(params[:id])
    if stock_unit.owner_id == current_user.id
      stock_unit.destroy!
      render body: nil, status: 204
    else
      render body: nil, status: 403
    end
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end

  private

  def stock_unit_params
    params.require(:stock_unit).permit(
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
