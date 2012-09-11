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

  many :bills
  belongs_to :account
  timestamps!

  
  def session_start
    session = self.current_bill.current_session
    if session
      return session.start
    else
      return 0.0
    end
  end

  def current_bill
    self.bills.sort("date.desc").first
  end

end
