class User < ActiveRecord::Base
  validates :encrypted_password, confirmation: true
  validates :encrypted_password, presence: true

  def self.authenticate(email, password)
    user = self.where(email: email).first
    user.correct_password?(password)
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end  

  def correct_password?(input_password)
    encrypted_password == secure_hash(input_password)
  end

end
