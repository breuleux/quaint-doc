
template :: default

meta ::
  title = Usage

nav side ::
  toc::

= Install

Assuming you have `npm installed:

bash & npm install quaint -g

This will install a `quaint command globally. It will be your main
tool unless you want to use the API@@@api.html directly or [write your own
plugins]@@@plugins/write.html.


= Compiling a document

First, let's see if everything works!
Write this in a file called `test.q:

&
  = Test
  
  _This is a
  
  * T
  * E
  * S
  * T

To compile the file into `test.html:
bash & quaint test.q

To print the result on standard out:
bash & quaint -s test.q

By default the `[@minimal] template is used, which inserts doctype,
html/head/body tags and so on. You can use the `[@none] template if
you don't want any of that:
bash & quaint -s test.q -t @none

If you want to see all the available flags:
bash % quaint -h


= Creating a configuration file

Run:
bash & quaint

with no arguments in a new directory to enter interactive setup. The
command will create a configuration file called `quaint.json (just go
with the defaults if you're not sure what to do). The command will
create the following file hierarchy:

&
  source_directory/
    quaint.json     Configuration file
    templates/      Template directory
      default.q     Default template
    content/        Content directory
      assets/       Put your static assets here (images etc.)
      index.q       Index page
      script.js     A global script (you don't have to use it)
      style.css     A global stylesheet (you don't have to use it)
    output/         This is where the output will go

You will be asked if you want to install plugins. You can choose from
[this list]@@@plugins/index.html. At any time you can add/configure
plugins with the following command:

& quaint --setup plugin-name

After this step, running `quaint again with no arguments will launch
compilation for all `[.q] files in [`content/] and (optionally) will
watch for changes and serve the contents.

= Templates

Templates are an important part of `quaint. They are very simple and
let you avoid repeating yourself.

Let's make a simple boilerplate template with the doctype, <html> tag
and whatnot. This is equivalent to the default `[@minimal] template:

__boilerplate.q

&
  doctype :: html
  html %
    head %
      title %
        meta::title !! Untitled
      meta %
        http-equiv = Content-type
        content = text/html
        charset = UTF-8
    body %
      {body}

Notice the line that reads `{body}: this is the place in the template
where the contents of our post will be inserted.

Put `boilerplate.q in the root directory or in the `templates/
directory, depending on your configuration or lack thereof.

Now you can write the post:

__post.q

&
  template :: boilerplate

  meta ::
    title = New post!

  Hello! This is a new post!

And run:

bash & quaint post.q

Alternatively the `[-t] flag can be used to force a template:

bash &
  quaint post.q -t tpl.q      # Will use tpl.q instead of boilerplate.q

It is possible for a template to have a template (using the same
`[template :: xyz] syntax that we saw). Just make sure not to create
cycles or self-referential templates, quaint won't like that at all.


= Advanced features

== Data injection

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

Once these are defined, try:

bash &
  quaint post.q -s -d data.json

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

See also the data@@@syntax.html#data macro, which lets you load data
inside quaint markup.


= Usage

You can access this help with `[quaint -h]:

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
    --format              Format (default: html)                 [default: "html"]
    -h, --help            Show help                                      [boolean]
    -o, --output          Directory to save the output into
    -p, --plugin          Plugin(s) to import:
                          * Quaint file (injected at the beginning)
                          * Path to JavaScript file
                          * Local npm module
                          * Global npm module
    -r, --resources       Directory where to put the resources (default: resources
                          /)
    --serve               Start server on specified port, in output directory
    -s, --stdout          Print to standard out         [boolean] [default: false]
    -t, --template        Template directory, or name of the default template to
                          use
    --template-directory  Template directory
    -v, --verbose         Print information about the operations performed
                                                                         [boolean]
    --setup               Set up and configure a plugin.          [default: false]
    -f, --from            Content root. Except for the output and template paths,
                          all paths are relative to this directory.
    -w, --watch           Watch for changes to rebuild

