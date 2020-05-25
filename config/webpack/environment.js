
const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// excluding node_modules from being transpiled by babel-loader.
environment.loaders.delete("nodeModules");

environment.plugins.prepend('Provide',
 new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  jquery: "jquery",
  Popper: ['popper.js', 'default']
}))

// const aliasConfig = {
//   'jquery': 'jquery-ui-dist/external/jquery/jquery.js',
//   'jquery-ui': 'jquery-ui-dist/jquery-ui.js'
// };

// environment.config.set('resolve.alias', aliasConfig);

// resolve-url-loader must be used before sass-loader
// https://github.com/rails/webpacker/blob/master/docs/css.md#resolve-url-loader
environment.loaders.get("sass").use.splice(-1, 0, {
  loader: "resolve-url-loader"
});

module.exports = environment
