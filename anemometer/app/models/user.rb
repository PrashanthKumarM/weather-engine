class User < ActiveRecord::Base
  
  attr_accessor :email, :name, :password, :password_confirmation

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
    c.validate_email_field = false
    c.validate_password_field = false
  end
  attr_accessor :password_confirmation

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.email
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end  

  def deliver_password_reset_instructions!
    reset_perishable_token!
    PasswordResetMailer.reset_email(self).deliver_now
  end
end
