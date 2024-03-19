class SubUserController < ApplicationController
  skip_forgery_protection

  def list
    render json: {data: SubUser.all}
  end

  def new
    begin
      sub_user = SubUser.new_sub_user(params)
      render json: { status: 201, message: "Criado com sucesso", data: sub_user }, status: :created, content_type: 'application/json'
    rescue StandardError => e
      render json: { status: 400, message: e.message, data: e.message }, status: :bad_request, content_type: 'application/json'
    end
  end

  def update
  end

  def delete
  end
end
