
## What's this?

This is a tool to explore new ways to spread tribal knowledge of a software project within a group.

Screencasting with accompanying text, articles,  question and answer, categorized information and gamification.

### Motivation

While wiki's such as Google Docs or Github wiki make it easy to enter data, a large complex project
can quickly become overwhelming in pure wiki form.

The goal of this project is to provide the tools to enable members of a development team to enter and
maintain the information that is useful to newcomers and existing members alike.

Q&A sites like StackOverflow are tremendously useful for getting answers to targeted questions.
Unfortunately,  it's not available for private groups.

In addition, the complex topics that an advanced software project needs to share can be difficult to squeeze
into a Q&A format.

Long form articles require a skilled writer to clearly and correctly teach a concept or topic.  Long, meandering
mind-dumps aren't pleasant to read through.  Tools to help manage the process of articles is necessary.

And finally, not everyone learns the same way.  Some people are audio/visual learners, and some topics are
better suited to demonstrating, rather than describing.  Tools to help generate generate non-annoying screencasts
are badly needed.



### Setup

* install mysql

* clone repo, then `bundle install`

* install sphinx.  using brew:

`brew install  sphinx --mysql` to install searchd

If you want to use the github omniauth provider (optional, not required):
* set two environment variables, the client app id ID
export GITHUB_KEY=your_key

* And the client Secret
export GITHUB_SECRET=some_secret

See http://developer.github.com/guides/basics-of-authentication/ for more info.

* seed the database:
`rake db:seed`

### Thanks
While the work on this project has been done outside of Coupa, special thanks to my employer,
Coupa Software, for allowing and encouraging me to do this side-project as open-source.


### please contribute
Pull requests gladly accepted!

### License

MIT-LICENSE
