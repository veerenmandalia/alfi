class Alfi::Providers::Base
  def initialize(query, searchType)
    @query = query
    @uri = URI.parse(query_url(query))
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @request = Net::HTTP::Get.new(@uri.request_uri)
    @searchType = searchType
    request_extensions if self.class.method_defined?(:request_extensions)
  end

  def query_url
    fail NotImplementedError
  end

  def call
    fail NotImplementedError
  end

  def add_to_list(helper_string)
    $result_list << helper_string
  end

  def add_suggestions(suggestions)
    $suggestions += Array(suggestions)
  end

  def add_repo_to_list(package)
    $result_list << "  compile '#{package}'".green
  end
end
