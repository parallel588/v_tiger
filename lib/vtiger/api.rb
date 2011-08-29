module Vtiger::API
  def list_types
    get('listtypes')['result']['types']
  end

  def describe(element_type)
    get('describe', :elementType => element_type)['result']
  end
  
  def create(elementType, element = {})
    post('create', :elementType => elementType, :element => element.to_json)
  end
  
  def retrieve(id)
    get('retrieve', :id => id)    
  end
  
  def query(query_string)
    get('query', :query => query_string)
  end
  
  def update(element)
    post('update', :element => element)
  end
  
  def delete(id)
    post('delete', :id => id)
  end
end