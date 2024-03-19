class User < ApplicationRecord
  # has_secure_password

  belongs_to :status
  belongs_to :subscription


  def self.new_user(params)
    user = User.new
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password_digest = params[:password_digest]
    user.status_id = params[:status_id]
    user.subscription_id = params[:subscription_id]
    user.save!

    user
  end
end
