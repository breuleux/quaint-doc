
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
  .plugin {
    display: -webkit-box;
    display: -webkit-flex;
    display: -ms-flexbox;
    display: flex;
    -webkit-flex-direction: row;
    -ms-flex-direction: row;
    flex-direction: row;
    -webkit-align-items: center;
    -ms-flex-align: center;
    align-items: center;
    padding: 5px;
    border-bottom: 2px solid #bbb;
  }
  .plugin .plugin-name {
    width: 200px;
  }
  .plugin .plugin-name a {
    color: #000;
  }
  .plugin .plugin-description {
    width: 400px;
  }

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


= Installing a plugin

Plugins listed here can be used in a Quaint project by running the
following following command:

& quaint --setup plugin-name

Most of them are configurable.


= Styling and highlighting

qplugin breuleux/quaint-bootstrap3 ::
  Includes [Bootstrap v3]@@http://getbootstrap.com/ CSS/JS files and
  defines many components to use bootstrap's features.

qplugin breuleux/quaint-emoji ::
  Macros to insert emoji characters.

qplugin breuleux/quaint-google-fonts ::
  Use [Google Fonts]@@https://www.google.com/fonts on your pages.

qplugin breuleux/quaint-highlight ::
  Syntax highlighting for a hundred of languages.

qplugin breuleux/quaint-look-nice ::
  An okay-looking, customizable and extensible stylesheet for your pages.


= Data formats

__json is supported by default.

qplugin breuleux/quaint-csv ::
  Format and include CSV files.

qplugin breuleux/quaint-yaml ::
  Format and include YAML files.


= Programming languages

qplugin breuleux/quaint-javascript ::
  Enables embedded JavaScript.

qplugin breuleux/quaint-earlgrey ::
  Enables embedded [Earl Grey]@@http://earl-grey.io~.

qplugin breuleux/quaint-coffeescript ::
  Enables embedded [CoffeeScript]@@http://coffeescript.org~.


= Other languages

qplugin breuleux/quaint-mathjax ::
  Includes [mathjax]@@https://www.mathjax.org/, which lets you write
  math with LaTeX syntax.

qplugin breuleux/quaint-quaint ::
  Embed interactive Quaint editors inside your pages.

qplugin breuleux/quaint-repple ::
  Interactive JavaScript or [Earl Grey]@@http://earl-grey.io interpreter

qplugin breuleux/quaint-sass ::
  Enables embedded [SASS]@@http://sass-lang.com/~.


= Others

qplugin breuleux/quaint-disqus ::
  Embed [Disqus]@@https://disqus.com comment threads.

qplugin breuleux/quaint-google-analytics ::
  Gather data with [Google Analytics]@@https://www.google.com/analytics/~.

qplugin breuleux/quaint-google-charts ::
  Display nice charts with
  [Google Charts]@@https://developers.google.com/chart/?hl=en~.

qplugin breuleux/quaint-google-maps ::
  Show a map using [Google Maps]@@https://maps.google.com with
  coordinates or an address.

qplugin breuleux/quaint-nav ::
  Provides a `[nav ::] macro to populate a navigation bar (but you
  need to style it yourself).

qplugin breuleux/quaint-share-buttons ::
  Put share buttons on your pages (Facebook, Twitter, Reddit, etc.)

qplugin breuleux/quaint-youtube ::
  Easily embed YouTube videos using their ID.


= Contributors

Please consult the documentation on
__[how to write a plugin @@@ plugins/write].

