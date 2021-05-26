

* get rake task to stop running twice
* updated various gems, removed best_in_place (in-place editor)
* added some basic rspec tests

* added ContentFixup to help with migrating forum to different domains, automatically
doing a simple regex substitution.  probably not the most bulletproof way to to do it,
but hopefully acceptable for a PoC
* fix some issues around the ancient userstamp library and make it work better with rails 6.
* This userstamp fix allows creating of new records, but much of the js is still broken. TODO


v0.0.2
Major upgrades:

* Upgraded Ruby, Rails and all associated gems.
* converted from zurb-foundation to bootstrap 4
* Added bootstrap themes (Thanks @kingkong!)
* add webpacker/yarn
* Beginning of docker configs to allow running locally with docker, as well as heroku
* convert to postgres for heroku
* rework front-page display data (top lists).  requires regular updates with rake task now.
* redo caching to use redis (heroku page caching issue)

v0.0.1 - first major version of tkn

