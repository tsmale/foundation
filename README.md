This branch is deployed to AWS Elastic Beanstalk:

`curl http://foundation-env.b5p8mv4nig.eu-west-2.elasticbeanstalk.com/?film=Top_Gun`

To release a new version, zip and upload to EB:

`zip foundation.zip -r * -x '*.git*'`

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
