class SecretsController < ApplicationController
  def new
  end

  def create
    secret = Secret.new(params[:secret])
    secret.author_id = current_user.id

    secret.save

    render json: secret
  end
end