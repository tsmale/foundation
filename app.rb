# frozen_string_literal: true

require 'sinatra'
require 'sparql/client'
require 'json'

set :bind, '0.0.0.0'

$cache = {}

helpers do
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
    sparql = SPARQL::Client.new('http://dbpedia.org/sparql')
    sparql.query(query)
  end

  def format_results(results)
    results_array = []
    results.each_entry do |result|
      results_array << result.bindings.values[0].to_s.sub('http://dbpedia.org/resource/', '')
    end
    return results_array
  end
end

get '/' do
  if params.empty?
    return ''
  end

  search_type = params.keys[0]
  search_term = params[search_type]
  types = %w[actor film]
  unless types.include?(search_type)
    return 'Invalid search type, expected "film" or "actor"'
  end

  cache_key = search_type + search_term
  if $cache.key?(cache_key)
    response = $cache[cache_key]
  else
    result = format_results(query(query_builder(search_type, search_term)))

    # Get the opposite search type for response and pluralise it
    response_type = (types.reject { |t| t == search_type })[0] + 's'
    response = { response_type => result }.to_json

    $cache[cache_key] = response
  end

  response
end
