class Emailsetting
  include MongoMapper::Document

  # key <name>, <type>
  key :address, String
  key :port, Integer
  key :user_name, String
  key :password, String
  key :authentication, String
  key :enable_starttls_auto, Boolean

  belongs_to :account
  timestamps!
end
