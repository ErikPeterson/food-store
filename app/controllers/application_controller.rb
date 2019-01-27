class ApplicationController < ActionController::API
  respond_to :json

  def validate_pagination_params!
    sort = params[:sort] || 'desc'
    if !['asc', 'desc'].include?(sort)
      raise "#{sort} is not a valid value for `sort'"
    end

    page = params[:page] ? params[:page].to_i : 1
    if page < 1
      raise "#{page} is not a valid value for `page'"
    end

    per_page = params[:per_page] ? params[:per_page].to_i : 10
    if per_page < 1
      raise "#{per_page} is not a valid value for `page'"
    end

    [sort, page, per_page]
  end
end
