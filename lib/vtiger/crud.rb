module Vtiger::Crud
  def create(elementType, element = {})
    post('create', :elementType => elementType, :element => element.to_json)
  end
  
  def retrieve(id)
    get('retrieve', :id => id)    
  end
  
  def update(element)
    post('update', :element => element)
  end
  
  def delete(id)
    post('delete', :id => id)
  end
end