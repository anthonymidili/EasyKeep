const { environment } = require('@rails/webpacker')

const coffee = require('./loaders/coffee')
environment.loaders.prepend('coffee', coffee)

// Jquery setup.
const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery'
  })
)
const config = environment.toWebpackConfig()
config.resolve.alias = {
  jquery: "jquery/src/jquery"
}

module.exports = environment
