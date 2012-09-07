class WorkSession
  include MongoMapper::Document

  # key <name>, <type>
  key :date, Date, default: Date.today
  key :description, String
  key :content, String
  key :active, Boolean
  key :start, Time, default: Time.new
  key :ende, Time
  key :profit, Float, default: 0.0

  belongs_to :client
  belongs_to :bill

  validate :only_one_active_session

  def only_one_active_session

  end
  
  timestamps!
end
