module VTiger::Query
  
  def build_query(objectType, options = {})
    @objectType     = objectType
    @options        = options
    @query           = get('query', :query => query_string)
    @query['result'] += get_more while more_results_needed?
    @query
  end
  
  def query_string(options = {})
    limit = options[:limit] || @options[:limit]
    [].tap do |query|
      query << 'select'
      query << '*'
      query << "from #{@objectType}"
      query << "limit #{limit}" if limit
      query << ';'
    end.join(' ')
  end
  
  def more_results_needed?
    @options[:limit].present? && @query['result'].count < @options[:limit]
  end
  
  def get_more
    offset = @query['result'].count
    new_limit = @options[:limit] - offset
    get('query', :query => query_string(:limit => "#{offset}, #{new_limit}"))['result']
  end
end