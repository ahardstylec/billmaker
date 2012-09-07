class Account
  include MongoMapper::Document
  attr_accessor :password, :password_confirmation

  # Keys
  key :name,             String
  key :surname,          String
  key :email,            String
  key :crypted_password, String
  key :role,             String

  many :clients

  # Validations
  validates_presence_of     :email, :role
  validates_presence_of     :password,                   :if => :password_required
  validates_presence_of     :password_confirmation,      :if => :password_required
  validates_length_of       :password, :within => 4..40, :if => :password_required
  validates_confirmation_of :password,                   :if => :password_required
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of       :role,     :with => /[A-Za-z]/
  validate :val_one_active_client

  # Callbacks
  before_save :encrypt_password, :if => :password_required

  ##
  # This method is for authentication purpose
  #

  def current_client
    self.clients.where(status: true).first
  end

  def self.authenticate(email, password)
    account = first(:email => email) if email.present?
    account && account.has_password?(password) ? account : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  private
  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password)
  end

  def password_required
    crypted_password.blank? || password.present?
  end

  # def clients_for_select
  #   self.clients.collect{ |client| [client.company, client.id] }
  # end

  def clients_for_select
    clients = self.clients.sort(:status).collect{ |client| [client.id, client.company] }
    ap clients
    clients
  end

  def val_one_active_client
    c = 0
    self.clients.each do |c|
      c += 1 if c.status
    end

    return false if c > 1

    return true
  end


end
