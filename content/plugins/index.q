
template :: default

meta ::
  title = Plugins


[qplugin \user/\name :: \description] =>
  div.plugin %
    div.plugin-name % __ {name.raw{}.replace{"quaint-", ""}}@@http://github.com/{user}/{name}
    div.plugin-description %
      {description}

[?!? \x] =>
  span.important %
    class = {x.raw{}.to-lower-case{}}
    {x}

css ::
  .important {
    display: inline-block;
    font-weight: bold;
    background: #000;
    color: white;
    padding: 5px;
  }
  .important.todo {
    background: #f00;
  }
  .important.incomplete {
    background: #a00;
  }
  .important.document {
    background: #00a;
  }

= Styling and highlighting

qplugin breuleux/quaint-bootstrap ::
  ?!?INCOMPLETE
  ?!?DOCUMENT
  Includes [bootstrap]@@http://getbootstrap.com/ CSS/JS files and
  defines many components to use bootstrap's features.

qplugin breuleux/quaint-emoji ::
  ?!?INCOMPLETE
  ?!?DOCUMENT
  Macros to insert emoji characters.

qplugin breuleux/quaint-google-fonts ::
  ?!?DOCUMENT
  Use [Google Fonts]@@https://www.google.com/fonts on your pages.

qplugin breuleux/quaint-highlight ::
  Syntax highlighting for a hundred of languages.

qplugin breuleux/quaint-look-nice ::
  ?!?DOCUMENT
  An okay-looking, customizable and extensible stylesheet for your pages.


= Data formats

qplugin breuleux/quaint-csv ::
  Format and include CSV files.

qplugin breuleux/quaint-yaml ::
  Format and include YAML files.


= Programming languages

qplugin breuleux/quaint-javascript ::
  Enables embedded JavaScript.

qplugin breuleux/quaint-earlgrey ::
  Enables embedded [Earl Grey]@@http://breuleux.github.io/earl-grey~.

qplugin breuleux/quaint-coffeescript ::
  Enables embedded [CoffeeScript]@@http://coffeescript.org~.


= Other languages

qplugin breuleux/quaint-mathjax ::
  Includes [mathjax]@@https://www.mathjax.org/, which lets you write
  math with LaTeX syntax.

qplugin breuleux/quaint-quaint ::
  ?!?DOCUMENT
  Embed interactive Quaint editors inside your pages.

qplugin breuleux/quaint-repple ::
  ?!?TODO
  Interactive interpreter.

qplugin breuleux/quaint-sass ::
  Enables embedded [SASS]@@http://sass-lang.com/.


= Others

qplugin breuleux/quaint-bib ::
  ?!?TODO
  Bibliography.

qplugin breuleux/quaint-disqus ::
  ?!?DOCUMENT
  Embed [Disqus]@@https://disqus.com comment threads.

qplugin breuleux/quaint-google-analytics ::
  Gather data with [Google Analytics]@@https://www.google.com/analytics/

qplugin breuleux/quaint-google-maps ::
  ?!?TODO
  Show a map using [Google Maps]@@https://maps.google.com with
  specified coordinates.

qplugin breuleux/quaint-link-templates ::
  ?!?TODO
  Define syntax for new types of links using simple templates.

qplugin breuleux/quaint-nav ::
  ?!?DOCUMENT
  Provides a `[nav ::] macro to populate a navigation bar (but you
  need to style it yourself).

qplugin breuleux/quaint-plot ::
  ?!?TODO
  Draw plots.

qplugin breuleux/quaint-share-buttons ::
  ?!?INCOMPLETE
  ?!?DOCUMENT
  Put share buttons on your pages (Facebook, Twitter, Reddit, etc.)

qplugin breuleux/quaint-video ::
  ?!?TODO
  Easily write video links for YouTube and Vimeo.


= Contributors

Please consult the documentation on
__[how to write a plugin @@@ plugins/write].

