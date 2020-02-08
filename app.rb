require 'sinatra'
require 'sparql/client'
require 'json'

$cache = {}

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
    array << result.bindings.values[0].to_s.sub('http://dbpedia.org/resource/','')
  end
  return array
end

get '/' do
  types = ['actor', 'film']
  search_type = params.keys[0]
  search_term = params[search_type]

  if not types.include?(search_type)
    return 'Invalid search type, expected "film" or "actor"'
  end

  if $cache.key?(search_term)
    puts 'Cache hit!'
    response = $cache[search_term]
  else
    result = format_results(query(query_builder(search_type, search_term)))

    # Select opposite search type for response, pluralised
    response_term = (types.select { |t| t != search_type })[0] + 's'
    response = { response_term => result }.to_json

    $cache[search_term] = response
  end

  return response
end
