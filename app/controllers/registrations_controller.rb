class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.save!

    render 'users/show.json', locals: { user: resource }
  rescue StandardError => e
    render json: { error: e.message }, status: 400
  end
end
