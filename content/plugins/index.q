
template :: default

meta ::
  title = Plugins

[plugin \user/\name :: \description] =>
  div.plugin %
    div.plugin-name % __ {name}@@http://github.com/{user}/{name}
    div.plugin-description %
      {description}


The following plugins are currently available. More will follow!
Follow the links for more information.


= Programming languages

plugin breuleux/quaint-javascript ::
  Enables embedded JavaScript.

plugin breuleux/quaint-earlgrey ::
  Enables embedded [Earl Grey]@@http://breuleux.github.io/earl-grey~.

plugin breuleux/quaint-coffeescript ::
  Enables embedded [CoffeeScript]@@http://coffeescript.org~.


= Syntax highlighting

plugin breuleux/quaint-highlight ::
  Syntax highlighting for a hundred of languages.


= Others

plugin breuleux/quaint-sass ::
  Enables embedded SASS.

plugin breuleux/quaint-yaml ::
  Format and include YAML files.

