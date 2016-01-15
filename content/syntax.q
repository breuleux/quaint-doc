
template :: default

meta ::
  title = Syntax

store sidebar ::
  toc::


[@$@ \repo] => {repo} @@ https://github.com/breuleux/{repo}


= Basics

Let's start with the basics, so that you can be productive right away!
Also, just so you know, each example is a live editor.

== Emphasis

A prefix underscore will emphasize a word. Use two for strong
emphasis.

&& _One underscore is _italics

&& __Two underscores is __bold

Brackets can be used to emphasize multiple words or parts of a word.

2 && The __[apple pie] was a[_ma]zing!

Alternatively you can use the tilde, which is a non-breaking space:

&& a~_ma~zing!


== Links

The `[@@] operator is used to create links. On the left goes the
link's label (optional) and on the right, the URL.

&& Google@@http://google.com

&& @@http://github.com

Again, you can group with brackets:

&& [Link to Google]@@http://google.com

Finally, you can put the URL in a variable@@[#variables] if you find
it more convenient:

&& Check out my blog@@{blog}~!
   blog => http://breuleux.net/blog

Also note the use of the tilde above. It is required otherwise the
`[!] is understood to be part of the URL.


== Images

The link syntax also serves to display images. Prefix the path with
`[image:]

&& @@image:assets/quaint-small.png

You can give images a title as well:

&& quaint@@image:assets/quaint-small.png

If you want to control the image's size or other properties you should
use the [`[%] operator @@ #htmlgeneration]:

&& img %
     src = assets/quaint-small.png
     alt = QUAINT
     height = 50px


== Headers

Begin a line with one equal sign for a `h1 tag, two for a `h2 tag, and
so on:

&& = h1
&& == h2
&& === h3
&& ==== h4
&& ===== h5
&& ====== h6



== Lists

An asterisk at the beginning of a line creates a bullet point.

&&
  * Bread
  * Tomatoes
  * Goat cheese

A hash sign, on the other hand, starts an ordered list.

&&
  # One!
  # Two!
  # Three!


== Tables

A leading `[+] creates a header row and a leading `[|] creates a
normal row.

&&
  + Name   + Surname     + Job
  | Alice  | Lovelace    | Physicist
  | Harold | Worthington | Banker

Of course, you may think aligning table elements is a little annoying,
or perhaps your table is stored in a JSON file and you would like to
make a table automatically for it.

In those cases I recommend you use [`format @@ #format] instead.


== Definitions

The `:=` operator creates definitions.

&&
  quaint :=
    A cool markup language.
  xml :=
    Not cool at all.


== Blockquotes

A prefix `[>] will create a blockquote. Consecutive lines will be
merged.

&&
  > Hello,
  > I am a great man

Although, you can use indent, too.

&&
  > Hello,
    I am a great man

Multiple blockquote levels can be done, but they require a space
between the `[>]s.

&&
  > > Hello!
  > Bonjour!


== Code blocks

The ampersand operator creates a code block:

&& & This is a code block

If you wish to highlight the code in a particular language, you need
to use the [quaint-highlight]@@{qhl} plugin and then write out the
language before the `[&]:

qhl => //github.com/breuleux/quaint-highlight

&& javascript &
     function square(x) {
         return x * x;
     }

This will _not work if you don't use the plugin.


== Inline code

A prefix backtick makes a word into inline code.

&& Here is `code

Normally you will want to use brackets:

&& Simple as `[1 + 1 = 2]

Note that only the outer bracket pair will be stripped off:

&& Simple as `[[1 + 1 = 2]]

For the rare case where you want to show an unmatched opening or
closing bracket as code, escape it with a backslash:

&& `[The opening bracket is \[]


== Comments

Any block that comes after `[;;] will be ignored by Quaint:

&& I have nothing to hide
   ;; except the rotting corpses
      of two elephants


= Escaping

If you want to print a character without triggering any special
meaning it may have, simply prefix it with a backslash.

&& \_\_Not \_emphasized

&& \[Bracketed!\]

&& You\~have\~to\~escape\~tildes

Also, Quaint thinks every sequence of operator characters is a
distinct operator. So while `[x@@#y] looks like a link to `[#y] it is
actually an application of the `[@@#] operator, which does not
exist. Escaping an operator character makes it a word character, so in
that case you can escape `[#] to get the desired behavior:

&& No@@#escaping

&& Yes@@\#escaping


= Whitespace/grouping


== Spacing

The spacing between an operator and its operand determine the priority
of the operator. More spacing means a larger operand. To put it
simply:

&& __One word is bolded
&& __ All the words are bolded
&& One word is linked@@index.html
&& All words are linked @@ index.html

Play a bit with the spacing above to get a feel of the results


== Indent

An indented block after an operator belongs to that operator:

&& * This is
     all inside
     the bullet point

&& __ all inside
      the strong emphasis

&& *
     You can also put the operator
     on its own line.


== Grouping

You can group together any chunk of text by enclosing it in square
brackets (`[[]]). They effectively behave like a single word.

&& [Brackets do [[[not]]] [show up]]

&& Emphasis on __one word

&& Emphasis on __[many words]

&& Here is [a link]@@[#grouping]

&& Here is [another link @@ #spacing]


= HTML Generation

The `[%] operator is used to generate arbitrary HTML nodes, if you
need to. The full syntax looks like this:

& tag#id.class %
    attribute = value
    child1
    child2
    ...

You can specify multiple classes. If there is no tag, the default is
`div.

&& x[sup % 2]

   img % src = assets/quaint-small.png

   span.err %
     style = color:red
     An __error occurred! (Not really)

You can also write the nodes more compactly by putting every property
and element inside square brackets.

2 && A a%[href=https://google.com][link] to google!

== Gotchas

Now here's what will __not work. `[%] cannot be used as a suffix
operator without adding a space (this is so that you can say that 100%
of crows are black or the glass is 50% full without creating tags,
which would be confusing). With a space before `[%], it will create a
tag, but with the space comes the need for grouping brackets. So a
line break, for example, is `[[br %]]~:

&& First br% line [br %] Second line

Notice how the first `[br%] is just shown normally and does not create
a `[<br>] tag, whereas `[[br %]] does!

Also, because of Quaint's fixed priorities (all operators are
right-associative), this will not work as intended (it creates a
`[<klass>] tag):

&& div.klass%nope

To make it work, put spaces around `[%], or brackets around
`[span.klass].

&& div.klass % yes
   [div.klass]%yes


== `html macro

Alternatively, you can embed HTML directly using one of these two
methods:

&& html ::
     <span>x<sup>2</sup></span>

   raw %
     <span>x<sup>2</sup></span>


== Inject CSS

&& === Injecting CSS!
   css ::
     .orange { color: orange; }
     .block {
       height: 100px;
       width: 100px;
       color: white;
       text-align: center;
       line-height: 100px;
       font-weight: bold;
       background: red;
     }

   Oranges are [span.orange % orange!]
   div.block % HELLO


== Inject JavaScript

Note that this is different from _embedding JavaScript: what I mean by
inject is to write code inside the generated HTML, with script
tags. This is done as follows:

& js :: javascript code

For example,

& js :: console.log("hello")

will print "hello" to the console when you load the page in the
browser. It will do nothing at generation time.


== HTML Sandbox

&& h3 % Let's generate HTML!
   ol %
     type = i
     li % 2[sup % 2] is 4
     li % 2[sup % 2[sup % 2]] is 16
     li % html ::
       <em>And so forth...</em>


= Variables

If there is a piece of markup you don't want to put in the middle of a
paragraph, for example a long URL for a link, or want to use multiple
times, then variables are for you. It's very simple:

& variable => contents
  ...
  {variable}


For example:

7 && smith03 => //some.where/thing.pdf
  
     Theropods are a family of dinosaurs which, according to the study by Smith@@{smith03}, had very large wings that allowed them to fly to the moon.

Better yet... you can define the variable __after it is used, and it
will work anyway!

9 && Quaint@@{q} is a language similar to Markdown@@{md} with a dash of Haml@@{haml}
    
     q => //breuleux.github.io/quaint
     md => //daringfireball.net/projects/markdown
     haml => //haml.info

A variable can be used multiple times.

&& k => __KNOCK!
   {k} {k} {k}


= Rules

Simply put, a rule is a reusable template that you assign a name or
an operator to. Rules help with terseness and code reusability,
although abusing them could make your code difficult to read. The
syntax for a rule is:

& [pattern] => template

A pattern is a normal Quaint expression, but any word which is
prefixed with a backslash becomes a _variable. The variable can be
inserted in the template using curly brackets (`{variable}). Here is
an example of a rule someone may write to make superscripts easier:

&& [\text ^ \superscript] =>
     {text}[sup % {superscript}]
   2^3

Both arguments must be present in order for the rule to work. If
either is absent, for instance `[^2] lacks the `text argument, the
rule will not be run. You can change this by declaring the argument
as `[\maybe\text] instead:

&& [\maybe\text ^ \superscript] =>
     {text}[sup % {superscript}]
   2^3 and ^3 match, but 2^ does not

Conversely, if you declare the pattern `[[^ \superscript]], Quaint
requires the operator to be prefix:

&& [^ \superscript] =>
     sup % {superscript}
   ^3 matches, but 2^3 and 2^ do not

== Behavior

Rules do _not modify Quaint's parser: the `[^] operator has always
existed, it is just that by default it just prints itself out. This is
an advantage, because rules in Quaint are predictable: the operator
we just defined is right-associative, because all operators in Quaint
are right-associative. They are sensitive to spacing like all
operators, they can be bracketed like all operators, and so on.

&& [\maybe\text ^ \superscript] =>
     {text}[sup % {superscript}]

   * Superscript ^one word
   * Superscript ^[multiple words]
   * Right associative: 2^3^4^5^6
   * Emphasized ^ _superscript
   * Superscripting ^
       a whole
       block!


== Rule Sandbox

15 &&
  css :: .orange { color: orange; }
  [/ \text] => span.orange % {text}

  I am a big fan of /oranges and other /[orange food] like /carrots.

  [?? \t] =>
    {t} @@ //wikipedia.org/wiki/{t}

  The ??orange is a ??fruit, who would have thought?



= Scripting

Curly brackets switch to "eval mode". They could contain JavaScript,
or Earl Grey, or something else. By default the "eval" used is just a
key-based load/store mechanism. Other scripting languages require
importing a plugin.

Supposing the [quaint-javascript]@@{qjs} plugin is used, as it is on this
site, then you can embed JS expressions:

qjs => //github.com/breuleux/quaint-javascript

&& 2 + 2 = {2 + 2}

You can also use JS inside rules. The variables declared by the rule
are also available in JavaScript! They are not strings, but you can
convert them into strings by calling the `raw method on them.

5 && [shout :: \text] =>
       {text.raw().toUpperCase()}

     shout :: hello! I don't mean to shout, but where's the beef?

It is also possible to build HTML programmatically. `quaint-javascript
comes with the `h function. If you use `h, though, make sure to call
`engine.gen on the arguments to apply Quaint markup to them! Unless
you are converting them to strings, that is. The markup will be lost
if you do that.

5 && [bolden :: \text] =>
       {h("b", {}, engine.gen(text))}

     bolden :: This is _bold!

With the `quaint command line and API, you can provide environment
variables for use inside curly brackets. See the `[-d] option for the
`quaint command.



= Conditionals

Generate something different depending on the value of a variable or
of metadata with conditionals:

First there is the `[condition ?? iftrue] construct:

&& {true} ?? yes
&& {false} ?? yes

You can add a branch to generate when the condition expression is
false with the `[!!] operator.

&& {true} ?? yes !! no
&& {false} ?? yes !! no

`[cond !! iffalse] is shorthand for `[cond ?? cond !! iffalse].

&& {true} !! no
&& {false} !! no

`{true} and `{false} trivially evaluate to `true or `false
respectively, but they are not super useful.

== On metadata

Meta variables, when they are not defined, will trigger the false
branch:

&& meta::x !! no

&& meta :: x = yes
   meta::x !! no

But be careful: if you want to set metadata to a falsey value, you
need to use `[:] and not `[=].

&& meta ::
     a = false
     b: false
   * meta::a ?? yes !! no
   * meta::b ?? yes !! no

That's because the definition for `a generates a Quaint node, that
is to say, a string of sorts, whereas the latter tries to interpret
the value as JSON.

== On variables

As conditionals, you can use variables imported with [`include @@
#include], with the `[-d] flag of the command line, or set by
[`setenv @@ api.html#setenv]

&& include json ::
     {"a": true, "b": false}
   * {a} ?? yes !! no
   * {b} ?? yes !! no


= Loops

The `each macro can be used to generate loops over various data. The
syntax is:

& each data variable ::
    body

  each data var1 var2 ... ::
    body

There are many kinds of data you can iterate on:

== On lists

&& groceries =>
     * bread
     * milk
     * bananas
   each {groceries} food ::
     # I need {food}

== On tables

Depending on whether it has a row of headers, a table is interpreted
either as a list of objects or as a list of lists:

With a header, it is a list of objects:

&& people =>
     + Name   + Age + Job
     | Alice  | 21  | baker
     | Bob    | 42  | banker
     | Carmen | 33  | fraud
   each {people} person ::
     * {person.Name} is {person.Age}
       years old and is a {person.Job}

Without, you have to declare a variable for each column, just like
this:

&& people =>
     | Alice  | 21 | baker
     | Bob    | 42 | banker
     | Carmen | 33 | fraud
   each {people} name age job ::
     * {name} is {age} years old
       and they are a {job}


== On documents

&& store names :: Alice
   store names :: Bob
   each dump::names name ::
     * Hello, {name}

== On metadata

&& meta ::
     tags: ["Cool", "Wow"]
   each meta::tags tag ::
     * Tagged: {tag}!

== On JSON

&&
   include json :: {
     "names": ["Alice", "Bob"],
     "people": {
       "Alice": "baker",
       "Bob": "banker"
     }
   }
   each {names} name ::
     * Hello, {name}!
   each {people} name job ::
     * {name} is a {job}

This works just as well if you [`include @@ #include] external data,
of course. Also, check out the @$@quaint-yaml plugin if you wish to
include and iterate over YAML.





= Macros

Macros are typically written with the `[::] operator, either as
`[macro :: body] or `[macro argument :: body].


== `css

See here @@ #injectcss


== `doctype

Generate a doctype tag for a document:

& doctype :: html
  ==> <!DOCTYPE html>


== `data

`data reads a data file and returns it (usually so you can put it in a
variable)

For example:

&
  movies => data :: movies.json

  = List of movies!
  each {movies} movie :: * {movie.title}

Also consider the @$@quaint-yaml plugin if you wish to fetch YAML
data:

&
  plugins :: yaml
  movies => data :: movies.yaml
  ...


== `dump

See `store @@ #store


== `each

See Loops @@ #loops


== `html

See here @@ #htmlmacro


== `format

`format lets you format JSON (and eventually other formats through
plugins) as lists, tables and so on.

==== `json

&&
   format json :: {
     "Name": "Bob",
     "Surname": "Smith"
   }

The JSON is formatted recursively, and Quaint markup inside strings
will be evaluated:

&&
   format json :: {
     "fruits": ["Apple", "__Banana"],
     "desserts": ["Cake", "Pie"]
   }

==== `json:table

But wait! There's more! You can tell not only how to parse the data,
but how to show it. For instance, `json:table will find a way to make
a table out of what you have:

&&
   format json:table :: [
     ["one", "two", "three"],
     ["un", "deux", "trois"],
     ["eins", "zwei", "drei"]
   ]

&&
   format json:table :: {
     "Alice":
       {"age": 14, "job": "student"},
     "Bob":
       {"age": 43, "job": "baker"},
     "Catherine":
       {"age": 31, "job": "senator"}
   }

==== Format files

If your data is in a file, you can import it like such:

& format data.json:table ::


== `include

`include reads a file and then does something special with it:

* The contents of a __quaint (.q) file are inserted in place.
* The contents of a __JSON (.json) file are imported as variables in
  an environment.

&
  include :: template
  include :: template.q
  include :: data.json, other-data.json

Also consider the @$@quaint-yaml plugin if you wish to include over
YAML:

&
  plugins :: yaml
  include :: data.yaml



== `meta

`meta lets you declare metadata: title, author, and so on.  It also
lets you print out the data elsewhere in the file.

6 && meta ::
       title = My Life
       author = Me!

     You are reading meta::title by meta::author.

You may define a field either with `[=] or `[:]. The difference is
that the former is interpreted with Quaint and the latter as JSON or
as a plain string. You can see the difference in those examples:

&& meta ::
     a = __Hello
     b: __Hello
   * meta :: a
   * meta :: b

&& meta ::
     a = [1, 2, 3]
     b: [1, 2, 3]
   * meta :: a
   * meta :: b

&& meta ::
     a = false
     b: false
   * meta::a ?? yes !! no
   * meta::b ?? yes !! no


== `plugin

This imports a plugin directly from Quaint. It won't work here in the
browser, but it will offline.

The syntax works like this:

& plugin name ::
    option = value
    ...

For example:

& plugin highlight ::
    defaultLanguage = python

You will need to install the corresponding packages locally. For
instance, for the `highlight plugin to work, you need to execute this
command beforehand:

& npm install quaint-highlight


== `plugins

This is shorthand to import plugins with their default options:

& plugins :: highlight javascript

This will import `quaint-highlight and `quaint-javascript with their
default options.


== `resources

The `resources macro lets you include files in your output. By
default, the resources will be inserted in the `head tag.

& resources ::
    style.css
    my-script.js

Depending on command-line options, the resources may be copied over to
a resource directory and linked to, or inlined directly in the output
(at the appropriate location). The default is to copy and link.


== `scope

`scope creates a new scope, so that all variables declared in the body
are only visible inside that body.

&& x => x-out
   y => y-out
   scope ::
     x => _x-in
     | __inside | {x} | {y}
   | __outside | {x} | {y}


== `store

`store is mostly useful in conjunction with the API@@@api and/or
templates. With this macro you can push data to an internal "document"
(a list of references, or a list of script tags to put in <head> for
instance), and then dump that document somewhere convenient. You don't
have to dump after everything has been stored.

&& store names ::
     # Bob
     # Clara

   dump :: names

   store names ::
     # Damian

One use case of `store is in Quaint's very documentation. The code for
this page declares:

& store sidebar ::
    toc::

That is to say, "put the table of contents in the sidebar". Then, the
template it is using dumps the contents of the sidebar document in the
sidebar.

You can also use `store and `dump along with `each.

&& store names ::
     Bob
     Clara

   each [dump :: names] name ::
     # {name}

   store names ::
     Damian

Notice, however, that Bob and Clara are part of the same element as far
as `each is concerned.


== `template

Define the template to use for this file. For example, if you specify

& template :: mytemplate

The Quaint compiler will go through the following steps:

# Generate the HTML for the whole file
# Put the HTML in the variable `body
# Fetch `mytemplate.q
# Go to 1 (with the original in the variable `body)

So if mytemplate.q contains:

& #header % header
  {body}
  #footer % footer

Then any file that uses it as a template will generate a header div
above and a footer div below.

The CLI lets you specify a template directory with the `[-t]
options. You can also customize how files are read.

Two templates are defined by default and can be used directly:

* `[@none] is the identity template.
* `[@minimal] is standard boilerplate.
  (doctype and `html/head/body tags with a `[meta charset=utf8])

Plugins can define more templates that use the `[@] syntax. Check
their documentation.


== `toc

`toc prints out a table of contents based on the headers declared in
the markup. It can be used anywhere in the file.

&& toc::
   = One
   = Two
   == Two point one
   == Two point two
   = Three


== `when

Alternative notation for the `[??] operator. They both work
identically.

&& when {true} :: hello
&& when {false} :: hello

See conditionals @@ #conditionals


= Error reporting

If an error occurs in a Quaint document, the error will be inlined
inside a span with class `error (which you can style yourself, for
example I suggest using bold red, so you don't accidentally skim over
your outrageous blunders).

&& There is an {error} here.

If you want more information about an error, a stack trace for
example, you can dump the `errors sub-document. Each error will
contain a link to its corresponding stack trace.

4 && An error [format json :: blah] and another {1 +}, woe is me!

     dump::errors

