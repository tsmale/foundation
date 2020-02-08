require 'sinatra'
require 'sparql/client'

def query_builder(search_type, search_term)
  prefix = "
    PREFIX dbo: <http://dbpedia.org/ontology/>
    PREFIX dbr: <http://dbpedia.org/resource/>
  "
  film_query = "
    SELECT DISTINCT ?actor WHERE {
      dbr:#{search_term} dbo:starring ?actor 
    }
  "
  actor_query = "
    SELECT DISTINCT ?film WHERE {
      ?film rdf:type dbo:Film .
      ?film dbo:starring dbr:#{search_term} .
    }
  "
  query = prefix + (search_type == 'film' ? film_query : actor_query)
end

def query(query)
  sparql = SPARQL::Client.new("http://dbpedia.org/sparql")
  results = sparql.query(query)
end

def format_results(results)
  array = []
  results.each_entry do |result|
    result.each_binding do |name, value|
      puts value
    end
  end
  return array
end


get '/' do
  search_type = params.keys[0]
  search_term = params[search_type]

  result = format_results(query(query_builder(search_type, search_term)))
end
