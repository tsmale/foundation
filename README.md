A simple POC Sinatra app for querying the [DBpedia](https://wiki.dbpedia.org/) endpoint with [SPARQL](https://www.w3.org/TR/rdf-sparql-query/). Retrieves the cast for a given film, or list of films starring a given actor.

---

Install Ruby 2.7.0 (if not already available):

`rbenv install`

Install bundler and gems:

```
gem install bundler
bundle install
```

Run:

`ruby app.ruby`

Make a request, e.g.:

`curl http://localhost:4567/?film=Top_Gun`

---

For hotreloading:
```
rerun 'ruby app.rb'
```

---

Setup/run tests:
```
rspec
```
