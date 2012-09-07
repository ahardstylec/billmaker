class Client
  include MongoMapper::Document
   attr_accessible :status
  
  # key <name>, <type>
  key :street, String
  key :city, String
  key :plz, String
  key :clientname, String
  key :company, String
  key :pay , Float
  key :status, Boolean

  many :work_sessions
  many :bills
  belongs_to :account
  timestamps!

  
  def session_start
    session = self.work_sessions.where(active: true).first
    session.start
  end

end
