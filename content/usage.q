
meta ::
  title = Usage
  template = default

resources ::
  toc!

store sidebar ::
  toc::

= Install

Very simple. Assuming you have `npm installed, write the command:

bash & npm install quaint -g

This will install a `quaint command globally. It will be your main
tool unless you want to use the API@@@api directly or write your own
plugins.


= Usage

Here's the help for the `quaint command:

&
  Usage: quaint <file ...> [options]
  
  Options:
    -d, --data      JSON string or file(s) defining field:value pairs to be made
                    available inside markup (as {field}):
                    * key:value
                    * {"key": value, ...}
                    * filename.json
                    * prefix::filename.json
    -e, --eval      Quaint string to parse directly
    -f, --format    Format (only html currently supported)       [default: "html"]
    -h, --help      Show help                                            [boolean]
    -o, --out       File or directory to save the output to
    -p, --plugin    Plugin(s) to import:
                    * Quaint file (injected at the beginning)
                    * Path to JavaScript file
                    * Local npm module
                    * Global npm module
    -s, --stdout    Print to standard out               [boolean] [default: false]
    -t, --template  Quaint file to use as template, or template directory
    -v, --verbose   Print information about the operations performed     [boolean]


= Templates

Templates are an important part of `quaint. They are very simple and
let you avoid repeating yourself.

Let's make a simple boilerplate template with the doctype, <html> tag
and whatnot. You might actually want to save this one!

__boilerplate.q

&
  raw % <!DOCTYPE html>
  html %
    head %
      meta %
         http-equiv = Content-type
         content = text/html
         charset = UTF-8
      title % meta :: title
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
  meta ::
    title = New post!
    template = boilerplate

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
same `[meta :: template = xyz] syntax that we saw). This is not a
problem at all unless you create a cycle (in which case `quaint will
crash).


= Plugins

Say you want to highlight some JavaScript in a post:

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
option multiple times or separate each plugin with a comma. For instance:

bash &
  quaint -p highlight -p javascript post.q
  quaint -p earlgrey,highlight post.q



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
braces. Use this tip wisely.






