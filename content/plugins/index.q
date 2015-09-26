
meta ::
  title = Plugins
  template = default

[plugin \user/\name :: \description] =>
  div.plugin %
    div.plugin-name % __ {name}@@http://github.com/{user}/{name}
    div.plugin-description %
      {description}


The following plugins are currently available. More will follow!
Follow the links for more information.

plugin breuleux/quaint-highlight ::
  Syntax highlighting for a hundred of languages.

plugin breuleux/quaint-javascript ::
  Enables embedded JavaScript.

plugin breuleux/quaint-earlgrey ::
  Enables embedded [Earl Grey]@@http://breuleux.github.io/earl-grey~.


