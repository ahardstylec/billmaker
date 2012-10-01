class Bill
  include MongoMapper::Document
  include MongoAutoincrement

  # key <name>, <type>
  key :date, Time
  key :steuerid, Integer, default: 0
  key :bill, Float, default: 0.0
  has_autoincrement :billnr

  belongs_to :client
  many :work_sessions

  before_create :inc_nr

  def current_session
    self.work_sessions.where(active: true).first
  end

  def inc_nr
    self.billnr  = (Bill.all.count+1).to_s+"/"+self.date.year.to_s
  end

  def get_hours
  	hours = 0
  	self.work_sessions.each{|w| hours += w.worktime}
  	hours
  end

  def add_profit(profit)
    set(bill: self.bill+profit)
  end

  timestamps!
end
