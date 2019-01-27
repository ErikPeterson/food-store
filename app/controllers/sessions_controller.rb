class SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render 'users/show.json.jbuilder', locals: { user: resource }
  end
end
