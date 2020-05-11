class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
  		   :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  #before_save :ensure_authentication_token
  after_create :send_admin_mail

  has_many :customers, dependent: :destroy

  def send_admin_mail
    UserMailer.send_welcome_email(self).deliver_later
  end

  def as_json(options={})
    {
      id: self.id,
      email: self.email
    }
  end

end
