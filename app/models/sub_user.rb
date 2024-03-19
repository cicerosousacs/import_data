class SubUser < ApplicationRecord
  belongs_to :user

  def self.new_sub_user(params)
    sub_user = SubUser.new
    sub_user.first_name = params[:first_name]
    sub_user.last_name = params[:last_name]
    sub_user.email = params[:email]
    sub_user.user_id = params[:user_id]
    sub_user.password_digest = params[:password_digest]
    sub_user.active = false
    sub_user.save!

    sub_user
  end
end
