
template :: default

meta ::
  title = Plugins


[qplugin \user/\name :: \description] =>
  div.plugin %
    div.plugin-name % __ {name}@@http://github.com/{user}/{name}
    div.plugin-description %
      {description}


= Programming languages

qplugin breuleux/quaint-javascript ::
  Enables embedded JavaScript.

qplugin breuleux/quaint-earlgrey ::
  Enables embedded [Earl Grey]@@http://breuleux.github.io/earl-grey~.

qplugin breuleux/quaint-coffeescript ::
  Enables embedded [CoffeeScript]@@http://coffeescript.org~.


= Syntax highlighting

qplugin breuleux/quaint-highlight ::
  Syntax highlighting for a hundred of languages.


= Others

qplugin breuleux/quaint-sass ::
  Enables embedded SASS.

qplugin breuleux/quaint-yaml ::
  Format and include YAML files.


= Contributors

Please consult the documentation on
__[how to write a plugin @@@ plugins/write].
