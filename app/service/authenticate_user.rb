class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user
  end

  private

  attr_accessor :email, :password

  def user
    raise 'Email não informado!' if email.blank?
    raise 'Senha não informada!' if password.blank?
    user = User.find_by(email: email) || SubUser.find_by(email: email)
  end
end