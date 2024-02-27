
# Archiving project

I haven't used this project in a number of years, and it's been unmaintained since then.  I'm going to archive this repo for now to not have to deal with all the security bot notifications.  However, if you're using this or would like to contribute or take over the project, please contact me (create an issue) and we can discuss futher.  This may be resurected at some point. 

**So long, and thanks for all the fish!**



## What is this?

An awkward name for a project to explore knowledge sharing and organization in a software development setting.

Features:
  * Q&A - think a private StackOverflow
  * Topics - A structured wiki
  * Video - upload and manage videos
  * Chat integration

Future additions:
  * improved editor(s) and editing workflow with better asset uploading.
  * Tests and quizzes
  * read-integration from chat applications
  * import from email by forwarding to application
  * Information "aging" and validation to help keep documentation fresh.
  * Make creation of multimedia easier with "asciinema"-like terminal recording/playback
    with audio and text.

### Motivation

Commonly used tools such as Google Docs or Github wiki make it easy to enter data, a large complex project can quickly become overwhelming due to unstructured and unmaintained form.  Other more focussed tools (e.g. Confluence) also may have their strengths and weaknesses.

The goal of this project is to provide the tools to enable members of a development team to enter and maintain the information that is useful to newcomers and existing members alike.  See https://www.youtube.com/watch?v=o-JL-so5Gm8 for a talk that resonates with the goals of this project.

Another excellent talk is [What nobody tells you about documentation](https://www.youtube.com/watch?v=t4vKPhjcMZg)

Q&A sites like StackOverflow are tremendously useful for getting answers to targeted questions. Unfortunately, it wasn't available for private groups until 2018 with [private repos for teams](https://stackoverflow.com/teams).  I haven't tried it yet, I'm sure it is amazing.  However, this project will continue to be open-source and be a testbed for the overall concept of leveling the knowledge of private teams.

### Local Setup

* docker and docker-compose should be installed locally.

build images:
```
$ docker-compose build
```

initialize local database:
```
$ docker-compose run tribalknow ./bin/setup
```

run locally:
```
$ docker-compose up
```

#### Installing without docker:

If you want to use the github omniauth provider (optional, not required):
* set two environment variables, the client app id ID
export GITHUB_KEY=your_key

* And the client Secret
export GITHUB_SECRET=some_secret

See http://developer.github.com/guides/basics-of-authentication/ for more info.

* seed the database:
`rake db:seed`

* launch with foreman:
`foreman start`

### Convert an existing mysql database to postgres

### Deploy to heroku

* create your heroku application
* add your heroku push path to the remote
* git push heroku master

The first time through on a fresh heroku app, you'll want to run `bin/setup-demo` or `bin/setup-heroku` to create and setup the database.

Add postgres addon (see https://devcenter.heroku.com/articles/heroku-postgresql#provisioning-heroku-postgres)


### Thanks
While the work on this project has been been largely done outside of Coupa, special thanks to my employer,
Coupa Software, for allowing and encouraging me to do this side-project as open-source.


### please contribute
Pull requests gladly accepted!

### License

MIT-LICENSE
