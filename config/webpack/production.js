process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const environment = require('./environment')

// avoid sourcemaps from being generated in production.
environment.config.merge({ devtool: "none" });

module.exports = environment.toWebpackConfig()
