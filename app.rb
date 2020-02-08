require 'sinatra'
require 'sparql/client'

def query_builder(key, value)
  prefix = "
    PREFIX dbo: <http://dbpedia.org/ontology/>
    PREFIX dbr: <http://dbpedia.org/resource/>
  "
  film_query = "
    SELECT DISTINCT ?actor WHERE {
      dbr:#{value} dbo:starring ?actor 
    }
  "
  actor_query = "
    SELECT DISTINCT ?film WHERE {
      ?film rdf:type dbo:Film .
      ?film dbo:starring dbr:#{value} .
    }
  "
  query = prefix + (key == 'film' ? film_query : actor_query)
end

def query(query)
  sparql = SPARQL::Client.new("http://dbpedia.org/sparql")
  results = sparql.query(query)
  results.each_entry do |result|
    result.each_binding do |name, value|
      puts value
    end
  end
end

get '/' do
  key = params.keys[0]
  value = params[key]

  query(query_builder(key, value))
end
