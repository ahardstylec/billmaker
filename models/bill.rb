class Bill
  include MongoMapper::Document

  # key <name>, <type>
  key :date, Date
  key :steuerid, Integer
  key :bill, Float

  belongs_to :client
  timestamps!
end
