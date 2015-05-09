require 'bcrypt'

class User < ActiveRecord::Base

  has_many :notes

  validates :name, presence: true
  validates :email, presence: true
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password_hash, presence: true
  # validates_length_of :password_hash, :minimum => 6, :maximum => 20

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

end
