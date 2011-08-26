module Vtiger::Query
  def query(objectType, *args)
    get('query', :query => "select * from #{objectType}")
  end
end