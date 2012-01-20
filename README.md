Inspired by the [compass command line tool](http://compass-style.org/help/tutorials/command-line/) and a few [existing rake tasks for earlier versions of sprockets](https://gist.github.com/222571), sprockets-watch is a tool for using [Sprockets](https://github.com/sstephenson/sprockets) outside of a Ruby on Rails project. Sprockets is an asset bundler and is now the default [asset bundler in Ruby on Rails 3.1](http://edgeguides.rubyonrails.org/asset_pipeline.html). The idea of this project is to enable asset bundling for projects that want to take advantage of modern web performance techniques but aren't using Ruby on Rails (shocking, right?). The goal is to use the [minimum config setup that Compass uses](http://compass-style.org/help/tutorials/configuration-reference/) where all you need to do is specify where your raw assets are located and where the bundled assets are supposed to go. Combined with [Compass sprites](http://compass-style.org/reference/compass/utilities/sprites/) and [Smusher](https://github.com/grosser/smusher) a tool like sprockets-watch should make it painless to create professional-quality static web assets regardless of the server backend that will eventually be used.

This is a work in progress and is missing any easy configuration. Eventually it should work very similarly to compass watch.

## Usage

Bundle

```
bundle install
```

Precompile (optional)

```
bundle exec rake precompile
```

Watch (optional)

```
bundle exec rake watch
```