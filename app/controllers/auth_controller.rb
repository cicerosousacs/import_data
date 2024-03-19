class AuthController < ApplicationController
  skip_forgery_protection

  def sign_in
    response = AuthenticateUser.new(params[:email], params[:password]).call
    if response
      token = Session.new_session(response)
      render json: { status: 200, message: "Autenticado com sucesso", data: { token: token } }, status: :ok, content_type: 'application/json'
    end
  rescue StandardError => e
    render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
  end

  def sign_out
    begin
      Session.delete_session(@token)
      render json: { status: 200, message: "Deslogado com sucesso" }, status: :ok, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: [] }, status: :bad_request, content_type: 'application/json'
    end
  end

  def change_password
  end
end
