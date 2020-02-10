This branch will auto-deploy to Heroku if rspec tests pass:

`curl https://foundation-14.herokuapp.com/?film=Top_Gun`

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
gem install rerun
rerun 'ruby app.rb'
```

---

Run tests:
```
rspec
```
