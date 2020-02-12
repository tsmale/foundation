A simple POC Sinatra app for querying the [DBpedia](https://wiki.dbpedia.org/) endpoint with [SPARQL](https://www.w3.org/TR/rdf-sparql-query/). Retrieves the cast for a given film, or list of films starring a given actor.

---

Install Ruby 2.7.0 (if not already available):

`rbenv install`

Install gems:

`gem install sinatra thin sparql-client json`

Run:

`ruby app.ruby`

Make a request, e.g.:

`curl http://localhost:4567/?film=Top_Gun`

---

For hotreloading:
```
gem install rerun
rerun 'ruby app.rb'
```

---

Setup/run tests:
```
gem install rspec rack-test
rspec
```
