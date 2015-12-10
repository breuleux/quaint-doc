
template :: default

meta ::
  title = Plugins


[qplugin \user/\name :: \description] =>
  div.plugin %
    div.plugin-name % __ {name}@@http://github.com/{user}/{name}
    div.plugin-description %
      {description}


= Data formats

qplugin breuleux/quaint-csv ::
  Format and include CSV files.

qplugin breuleux/quaint-yaml ::
  Format and include YAML files.


= Syntax highlighting

qplugin breuleux/quaint-highlight ::
  Syntax highlighting for a hundred of languages.


= Programming languages

qplugin breuleux/quaint-javascript ::
  Enables embedded JavaScript.

qplugin breuleux/quaint-earlgrey ::
  Enables embedded [Earl Grey]@@http://breuleux.github.io/earl-grey~.

qplugin breuleux/quaint-coffeescript ::
  Enables embedded [CoffeeScript]@@http://coffeescript.org~.


= Others

qplugin breuleux/quaint-bootstrap ::
  Includes [bootstrap]@@http://getbootstrap.com/ CSS/JS files and
  defines many components to use bootstrap's features.

qplugin breuleux/quaint-mathjax ::
  Includes [mathjax]@@https://www.mathjax.org/, which lets you write
  math with LaTeX syntax.

qplugin breuleux/quaint-sass ::
  Enables embedded [SASS]@@http://sass-lang.com/.


= Contributors

Please consult the documentation on
__[how to write a plugin @@@ plugins/write].
