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

  belongs_to :bill

  def worktime
    return ((self.ende.to_f - self.start.to_f)/3600).round(2)
  end
  
  timestamps!
end
