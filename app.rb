require 'sinatra'
require 'sparql/client'

def query(key, value)
  sparql = SPARQL::Client.new("http://dbpedia.org/sparql")
  film_query = "
    PREFIX dbo: <http://dbpedia.org/ontology/>
    PREFIX dbr: <http://dbpedia.org/resource/>
    SELECT ?actor WHERE {
      dbr:#{value} dbo:starring ?actor 
    }
  "
  actor_query = "
    PREFIX dbo: <http://dbpedia.org/ontology/>
    PREFIX dbr: <http://dbpedia.org/resource/>
    SELECT ?film WHERE {
      ?film rdf:type dbo:Film .
      ?film dbo:starring dbr:#{value} .
    }
  "
  results = sparql.query(key = 'film' ? film_query : actor_query)
  results.each_entry do |result|
    result.each_binding do |name, value|
      puts value
    end
  end
end

get '/' do
  key = params.keys[0]
  value = params[key]

  query(key, value)
end
