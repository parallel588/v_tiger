class Vtiger::API
  format :json
  def list_types
    puts Vtiger.session
    get('listtypes')['result']['types']
  end

  def describe(element_type)
    puts Vtiger.session
    get('describe', {:elementType => element_type})['result']
  end
  
  def create(elementType, elementObject = {})
  # def create(elementType, )
    # puts Vtiger.uri
    # puts Vtiger.user
    # puts Vtiger.key
    puts Vtiger.session
    post('create', elementObject)
  end
  
  def get(operation, query = {})
    query = {:operation => operation, :sessionName => Vtiger.session}.merge(query)
    Vtiger.get(Vtiger.uri, :query => query)
  end
  
  def post(operation, body = {})
    body = {:operation => operation, :sessionName => Vtiger.session}.merge(body)
    Vtiger.post(Vtiger.uri, :body => body)
  end
end