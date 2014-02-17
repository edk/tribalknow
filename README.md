
## README

* Explore new ways to spread tribal knowledge of a software project within a group.

  Screencasting with accompanying text, question and answer, categorized information and gamification.

### warning: under heavy development

### Setup

* install postgress
  You'll need to set a password for the postgres user you intend to use.

* clone repo, `bundle install`

* install sphinx.  using brew:

`brew install  sphinx --mysql --pgsql` to install searchd that knows how to talk to postgress and mysql

If you want to use the github omniauth provider (optional, not required):
* set two environment variables, the client app id ID
export GITHUB_KEY=your_key

* And the client Secret
export GITHUB_SECRET=some_secret

See http://developer.github.com/guides/basics-of-authentication/ for more info.

* seed the database:
`rake db:seed`

