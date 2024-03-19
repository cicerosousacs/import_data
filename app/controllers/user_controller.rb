class UserController < ApplicationController
  skip_forgery_protection
  before_action :authenticated?, except: [:list, :new]

  def list
    render json: {data: User.all}
  end

  def new
    begin
      user = User.new_user(params)
      render json: { status: 201, message: "Criado com sucesso", data: user }, status: :created, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: e.message }, status: :bad_request, content_type: 'application/json'
    end
  end

  def update
  end

  def delete
  end

end
