
## README

* Explore new ways to spread tribal knowledge of a software project within a group.

  Screencasting with accompanying text, question and answer, categorized information and gamification.

### warning: under heavy development

### Setup

* install postgress

* clone repo, `bundle install`

* `bundle exec rake sunspot:solr:run` to start the search engine.  You'll need Java(tm) installed for this work.

* set two environment variables, the client app id ID
export GITHUB_KEY=your_key

And the client Secret
export GITHUB_SECRET=some_secret

See http://developer.github.com/guides/basics-of-authentication/ for more info.

* seed the database:
`rake db:seed`

