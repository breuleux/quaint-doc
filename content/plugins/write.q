
template :: default

meta ::
  title = Writing plugins

nav side ::
  toc::


= Writing plugins


Writing a plugin for Quaint is easy. You need to write a module that
exports a single function. That function should support the following
three call formats:

* [__ `myplugin(quaintEngine, options)] (call with Engine and options)
* [__ `myplugin(quaintEngine)] (call with Engine, use default options)
* [__ `myplugin(options)(quaintEngine)] (call with options, call result with Engine)

`quaintEngine is an instance of [`Engine @@@ api.html#engine]. If you
want to know whether an object is an `Engine or not, just check the
`isQuaintEngine property.

== Template

In the spirit of keeping things simple, I suggest you copy the
following template and don't worry about it:

javascript &

  function myplugin(quaintEngine, options) {
  
      // An Engine defines isQuaintEngine = true
      if (!quaintEngine.isQuaintEngine) {
          // Not an Engine, so the options are the first argument:
          options = quaintEngine;
          return function (realQuaintEngine) {
              return myplugin(realQuaintEngine, options);
          }
      }

      // Initialize options to an empty object if no options are given
      options = options || {};

      // The interface is satisfied, we have an Engine, we have options,
      // do stuff with them!
      doSomethingWith(quaintEngine, options);
  }

  // Quaint expects you to export the plugin function directly.
  // Just do this:
  module.exports = myplugin;


As for the plugin itself, I recommend reading the api@@@api document
for an overview of the `Engine and `QAst interfaces.


= Example

Here is an example to get you started.


__ `myplugin.js

javascript &
  // Use h to build HTML. If you try to return HTML as a string,
  // Quaint will sanitize it, so it won't work.
  var h = require("quaint").h;
  
  function myplugin(engine, options) {
  
      if (!engine.isQuaintEngine) {
          options = engine;
          return function (realEngine) {
              return myplugin(realEngine, options);
          }
      }

      options = options || {};
  
      // $thing ==> <options.dollarTag>thing</options.dollarTag>
      engine.registerRules({
          "$ \\x": function (engine, vars) {
              return h(options.dollarTag || "span",
                       engine.gen(vars.x));
          }
      });
  
      // color red :: hello ==> <span style="color:red">hello</span>
      engine.registerMacros({
          "color": function (engine, color, body) {
              return h("span",
                       {style: "color:" + color.raw()},
                       engine.gen(body));
          }
      });
  
  }
  
  module.exports = myplugin;


Copy this in a file, and then you can test it with `quaint
immediately, like this:

bash &
  quaint -p .myplugin -e 'Hello $world'
  quaint -p .myplugin -e 'color green :: grass'
  quaint -p '.myplugin{"dollarTag": "s"}' -e 'Hello $world universe'

The leading dot on `myplugin is needed to tell Quaint to get the
package in the current working directory. If you create a package, you
use the package name without the dot and without the `[quaint-] prefix
if applicable. Note that it has to be installed locally or globally at
the invocation point.



= Testing

Assuming your plugin is in the file `[../index.js], the following code
will create and execute Quaint instances with it:

javascript &
  var quaint = require("quaint");
  var myplugin = require("../index.js");

  // Default options
  var q1 = quaint(myplugin);

  // Setting different options
  var q2 = quaint(myplugin({option: value, ...});

  // Generating HTML
  var html = q2.toHTML("some markup");

This should be easy to adapt to your favorite test framework.



= Publishing

Publish your plugin on npm@@https://npmjs.org under a descriptive name and the
prefix `[quaint-]. For instance, if you are writing a plugin that adds
a rule for Wikipedia links you could name it `[quaint-wikilinks].

Then, users will be able to install and then use your plugin like
this:

bash &
  # Install
  npm install quaint-wikilinks -g
  # Use
  quaint -p wikilinks post.q



= Plugin list

For convenience there is a [list of plugins]@@@plugins/index on
Quaint's website.

The source for that page is located here@@{src}. If you write a new
plugin, please add it to the list at an appropriate place (you can
create a new section if needed) and make a pull request :\)

src => https://github.com/breuleux/quaint-doc/blob/master/content/plugins/index.q

