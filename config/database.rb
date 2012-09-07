MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'billmaker_development'
  when :production  then MongoMapper.database = 'billmaker_production'
  when :test        then MongoMapper.database = 'billmaker_test'
end
