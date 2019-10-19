
## What is this?

A tool to explore new ways to spread tribal knowledge of a software project within a group.

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

Commonly used tools such as Google Docs or Github wiki make it easy to enter data, a large complex project can quickly become overwhelming due to unstructured and unmaintained form.

The goal of this project is to provide the tools to enable members of a development team to enter and maintain the information that is useful to newcomers and existing members alike.  See https://www.youtube.com/watch?v=o-JL-so5Gm8 for a talk that resonates with
the goals of this project.

Q&A sites like StackOverflow are tremendously useful for getting answers to targeted questions. Unfortunately, it's not available for private groups.  2018 update: half a decade later, S/O now offers [private repos for teams](https://stackoverflow.com/teams).  I haven't tried it yet, but if it's anything like S/O, I'm sure this amazing.  However, this project will continue to be open-source and be a testbed for the overall concept of leveling the knowledge of private teams.

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
Add postgres addon (see https://devcenter.heroku.com/articles/heroku-postgresql#provisioning-heroku-postgres)


### Thanks
While the work on this project has been been largely done outside of Coupa, special thanks to my employer,
Coupa Software, for allowing and encouraging me to do this side-project as open-source.


### please contribute
Pull requests gladly accepted!

### License

MIT-LICENSE
