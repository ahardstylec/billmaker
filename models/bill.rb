class Bill
  include MongoMapper::Document

  # key <name>, <type>
  key :month, Integer, default: 0
  key :year, Integer, default: 0
  key :steuerid, Integer, default: 0
  key :billnr, String, default: ""
  key :bill, Float, default: 0.0


  belongs_to :client
  many :work_sessions

  before_create :inc_nr

  def inc_nr
    self.billnr  = (Bill.all.count+1).to_s+"/"+self.year.to_s
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
