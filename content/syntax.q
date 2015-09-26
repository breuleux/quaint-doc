
meta ::
  title = Syntax
  template = default

resources ::
  toc! edit!
  highlight.pack.js

store sidebar ::
  toc::


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


== Code blocks

The ampersand operator creates a code block:

&& & This is a code block

If you wish to highlight the code in a particular language, use the
[quaint-highlight]@@{qhl} plugin and then write out the language
before the `[&]:

qhl => //github.com/breuleux/quaint-highlight

&& javascript &
     function square(x) {
         return x * x;
     }


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


= Whitespace and grouping


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

& tag.class1.class2#id %
    attribute = value
    child1
    child2
    ...

If there is no tag, the default is `div.

&& x[sup % 2]

   img % src = assets/quaint-small.png

   span.err %
     style = color:red
     An __error occurred! (Not really)


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



= Macros

Macros are typically written with the `[::] operator, either as
`[macro :: body] or `[macro argument :: body].


== `meta

`meta lets you declare metadata: title, author, template, and so on.
It also lets you print out the data elsewhere in the file.

6 && meta ::
       title = My Life
       author = Me!

     You are reading meta::title by meta::author.


== `toc

`toc prints out a table of contents based on the headers declared in
the markup. It can be used anywhere in the file.

&& toc::
   = One
   = Two
   == Two point one
   == Two point two
   = Three


== `store

`store is mostly useful in conjunction with the API@@@api and/or
templates. With this macro you can push data to an internal "document"
(a list of references, or a list of script tags to put in <head> for
instance), and then dump that document somewhere convenient. You don't
have to dump after everything has been stored.

&& store names ::
     Bob
     Clara

   store names :: dump!

   store names ::
     Damian

One use case of `store is in Quaint's very documentation. The code for
this page declares:

& store sidebar ::
    toc::

That is to say, "put the table of contents in the sidebar". Then, the
template it is using dumps the contents of the sidebar document in the
sidebar.


== `html

See here @@ #htmlmacro

== `css

See here @@ #injectcss













;;    * 



;; = List of operators

 In what follows, `[\x] and other escaped words are placeholders for
 variables.

 + Name             + Pattern
 | Emphasis         | `[_ \x]
 | Strong emphasis  | `[__ \x]
 | Link             | `[\maybe\label @@ \maybe\url]
 | Code             | `[\maybe\language ` \code]
 | Code block       | `[\maybe\language & \code]
 | List             | `[* \x]
 | Ordered list     | `[# \x]
 | Table            | `[+ \x] and `[|\x]
 | Group            | `[[ \x]]
 | Eval             | `[{ \x}]
 | Header 1         | `[= \x]
 | Header 2         | `[== \x]
 | Header 3         | `[=== \x]
 | Header 4         | `[==== \x]
 | Header 5         | `[===== \x]
 | Header 6         | `[====== \x]


;; = List of functions

 + Name   + Purpose
 | meta   | Define metadata
 | store  | Store 
 | toc    | Table of contents
















;; == Basic troubleshooting

;; Here are some quick and dirty tips to keep in mind if you ever run
   into issues or mysteries:

;; div#interactive-spacing %
  interactive ::
    # __Escape an operator character with a __backslash:
      * \_ not emphasized
      * this is \@\@ not a link
    # You will need to __[escape brackets] sometimes
      * \[this is not a group\]
      * :\)
    # The __tilde (`[~]) is a __non-printing space
      * he~llo, you are a~_ma~zing!
    # Square brackets (`[[]]) __[group things together]
      * This is [[fool proof]@@[#basictroubleshooting]]

;; * `[[]] __[will not close] if the line with the closing bracket is
  indented further than the one with the opening bracket. For
  instance:
  &
    this [will not close
        <-- because of the indent]

    but this [will
        close
    without any issues]
