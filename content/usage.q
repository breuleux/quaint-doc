
template :: default

meta ::
  title = Usage

nav side ::
  toc::

= Install

Assuming you have `npm installed:

bash & npm install quaint -g

This will install a `quaint command globally. It will be your main
tool unless you want to use the API@@@api directly or [write your own
plugins]@@@plugins/write.


= Getting started

Run the `quaint command in a new directory with no arguments to enter
interactive setup. The command will create a configuration file called
`quaint.json. You usually want to pick the defaults.

You will be asked if you want to install plugins. You can choose from
[this list]@@@plugins/index.html. At any time you can add/configure
plugins with the following command:

& quaint --setup plugin-name


= How Quaint works

Quaint compiles Quaint source files in a designated content directory,
and writes the result in an output directory. It also copies 


* `contentRoot and `sources determine wh





A Quaint project TODO



* __quaint.json: The configuration file.
* __templates/~: The template directory.
* __content/~: The source directory.
* __content/assets/~: Images, media and other files to copy over.
* __output/siteRoot/~: The output directory.
* __output/siteRoot/resources/~: Where Quaint puts stylesheets, scripts and
  other resources.





= `quaint.json

`quaint.json contains the configuration for a Quaint project. Here is
a list of all options and their meaning:

* __contentRoot: The directory that contains the Quaint source files.

* __sources: An array of files or globs to compile. Use `[**/*.q] to
  compile all Quaint files. All the paths are relative to `contentRoot.

* __files: A list of files and directories to copy over to the output
  directory. All the paths are relative to `contentRoot. Unlike
  `resources.files, these files are simply copied over.

* __templates: Configuration for the template directory.
  * __root: The root directory for the project's templates.
  * __default: The name of the default template. Set to `[@none] if you want no
    default template.

* __output: The output directory.

* __resources: Configuration for the project's resources (CSS, JS, etc.)
  * __root: The sub-directory of the _output in which the resources will be put.
    This path is relative to `output.
  * [__files:] A map from _output resource name to the _input resource; the
    input resource path is relative to `contentRoot, the output resource path
    is relative to `resources.root.

    It is important to note that Quaint will _link the resources
    listed here in _every generated file. That is to say, if you put a
    stylesheet here, then Quaint will link it in in every `[<head>] of
    every `[.html] file it generates from a `[.q] file. If you only
    want to include a resource in a few files, see the
    `resources@@syntax.html#resources macro.

* __hostname: The domain where you will host your files, for example
  `http://my-site.com, or `https://personal.example.name:8080~.

* __siteRoot: The path from your domain's root where you will host
  your files.



json &
  {
    "contentRoot": "content",
    "sources": [
      "**/*.q"
    ],
    "files": [
      "assets"
    ],
    "templates": {
      "root": "template",
      "default": "default"
    },
    "output": "output",
    "resources": {
      "root": "resources",
      "files": {
        "style.css": "style.css",
        "script.js": "script.js"
      }
    },
    "hostname": "http://localhost",
    "siteRoot": "/",
    "server": {
      "enable": true,
      "startPage": "index.html",
      "port": 9137
    },
    "watch": true,
    "plugins": {}
  }





= Usage

Here's the help for the `quaint command:

&
  Usage: quaint <file ...> [options]
  
  Options:
    -c, --config          Path to a configuration file with option values (must be
                          JSON)                           [default: "quaint.json"]
    -d, --data            JSON string or file(s) defining field:value pairs to be
                          made available inside markup (as {field}):
                          * key:value
                          * {"key": value, ...}
                          * filename.json
                          * prefix::filename.json
    -e, --eval            Quaint string to parse directly
    -f, --format          Format (only html currently supported)
    -h, --help            Show help                                      [boolean]
    --inline              Inline resources in the HTML
    -o, --out             File or directory to save the output to
    -p, --plugin          Plugin(s) to import:
                          * Quaint file (injected at the beginning)
                          * Path to JavaScript file
                          * Local npm module
                          * Global npm module
    -r, --resources       Directory where to put the resources
    --resources-url       URL for the resources directory
    --serve               Start server on specified port, in output directory
                                                                  [default: false]
    -s, --stdout          Print to standard out         [boolean] [default: false]
    -t, --template        Name of the default template to use
    --template-directory  Template directory
    -v, --verbose         Print information about the operations performed
                                                                         [boolean]
    --setup               Set up and configure a plugin.          [default: false]
    -w, --watch           Watch for changes to rebuild            [default: false]


= Templates

Templates are an important part of `quaint. They are very simple and
let you avoid repeating yourself.

Let's make a simple boilerplate template with the doctype, <html> tag
and whatnot. You might actually want to save this one!

__boilerplate.q

&
  doctype :: html
  html %
    head %
      meta %
         http-equiv = Content-type
         content = text/html
         charset = UTF-8
      title % [meta :: title] !! Untitled
      link %
         rel = stylesheet
         type = text/css
         href = my-stylesheet.css
    body %
      {body}

Notice the line that reads `{body}: this is the place in the template
where the contents of our post will be inserted.

Now you can write the post:

__post.q

&
  template :: boilerplate

  meta ::
    title = New post!

  Hello! This is a new post!

And run:

bash & quaint post.q

Quaint will automatically fetch the template and fill it. It will also
use the meta-information for the title and put it at the right place!

Alternatively the `[-t] flag can be used to either force a template or
point Quaint to a template directory (so you can be neatly organized):

bash &
  quaint post.q -t tpl.q      # Will use tpl.q instead of boilerplate.q
  quaint post.q -t templates/ # Will use templates/boilerplate.q

Lastly: it is possible for a template to have a template (using the
same `[template :: xyz] syntax that we saw). This is not a
problem at all unless you create a cycle (in which case `quaint will
crash).


= Plugins

Say you want to highlight some Javascript in a post:

__post.q

& Here's my super cool square function:

  javascript &
    function square(x) {
        return x * x;
    }

By default, Quaint will not do it. But the `quaint-highlight plugin
will do it.

First you can install it globally (locally will work too):

bash &
  npm install quaint-highlight -g

Once this is done you can refer to it by name (without the `[quaint-]
part):

bash &
  quaint -p highlight post.q

This will save the result in `post.html. This uses
[highlight.js @@ https://highlightjs.org/].
You will need to include a stylesheet as well. They are available
[here @@ https://github.com/isagalaev/highlight.js/tree/master/src/styles].

You may of course use as many plugins as you want, just use the `[-p]
option multiple times. For instance:

bash &
  quaint -p highlight -p javascript post.q

If plugins can take options, you can provide them on the command line
by writing them out as JSON next to the plugin name, like this:

bash &
  quaint -p 'highlight{"defaultLanguage: "python"}' post.q

Note that you can specify and configure plugins inside a Quaint file
with the [`plugin @@ syntax.html#plugin] macro, although that will
only work on a per-file basis.


= Data injection

Let's create two files:

* `post.q will contain the Quaint markup we want to render
* `data.json will contain data for the render

__post.q

&
  The individual is named {name} {surname}.
  They are {gender} and were born on {birthdate}.

__data.json

json &
  {
    "name": "Alice",
    "surname": "Lovelace",
    "gender": "female",
    "birthdate": "1960/06/21"
  }

Once these are defined, simply write:

bash &
  quaint post.q -d data.json

The data will be filled in as you would expect. Moreover, you can
override parts of the data directly on the command line. For instance,
if you want Alice's surname to be Pottergeist instead, you can do
this:

bash &
  quaint post.q -d data.json -d surname:Pottergeist

Or this:

bash &
  quaint post.q -d data.json -d '{"surname": "Pottergeist"}'

If you use the `quaint-javascript plugin, all of the JSON contents
become top-level variables. This means that you could, for instance,
calculate Alice's age from her birthdate as an expression inside curly
braces.



= Configuration file

If there is a `quaint.json file in the current directory, its contents
will be used to fill in the options for generation. You can also
specify a different configuration file with the `[-c] option.

Here is a sample `quaint.json file:

json &
  {
      "sources": "src",
      "output": "out",
      "template": "templates",
      "data": {
          "name": "Roland",
          "surname": "Worthington"
      },
      "plugins": {
          "javascript": {},
          "highlight": {"defaultLanguage": "python"}
      }
  }

Then, executing `quaint with no arguments, or `[quaint -c
quaint.json], will be equivalent to running it with the following
options:

& quaint \
    -o out \
    -t templates \
    -d'{"name": ...}' \
    -p javascript \
    -p 'highlight{"defaultLanguage": "python"}' \
    src

Options in the configuration file can be supplemented (or overriden)
with command line options.

