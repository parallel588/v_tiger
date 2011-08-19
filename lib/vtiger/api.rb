class Vtiger::API
  def list_types
    get('listtypes')['result']['types']
  end

  def describe(element_type)
    get('describe', {:elementType => element_type})['result']
  end
  
  def create(elementType, element = {})
    post('create', :elementType => elementType, :element => element.to_json)
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