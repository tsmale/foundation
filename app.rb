require 'sinatra'
require 'sparql/client'

def query(thing)
  sparql = SPARQL::Client.new("http://dbpedia.org/sparql")
  query_str = "
    SELECT DISTINCT ?thing WHERE {
      ?thing rdf:type <http://dbpedia.org/ontology/#{thing}> .
    }
    LIMIT 10
  "
  results = sparql.query(query_str)
  results.each_entry do |result|
    result.each_binding do |name, value|
      puts value
    end
  end

end

get '/' do
  query('Film')
end
