class SecretsController < ApplicationController
  def new
  end

  def create
    @secret = Secret.new(params[:secret])
    @secret.author_id = current_user.id

    if @secret.save
      redirect_to user_url(@secret.recipient)
    else
      flash.now[:errors] = @secret.errors.full_messages
      render :new
    end
  end
end