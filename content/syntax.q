
meta ::
  title = Index
  template = default

resources ::
  edit! toc!

store sidebar ::
  toc::

;; div.sidenav %
  div.sidenav-contents %
    toc::


Welcome to the documentation about Quaint's syntax!


= Basics

Let's start with the basics. Pay attention to the textarea on the
left: it shows you the syntax to produce what's on the right. It is
also editable! Do not hesitate to change a few things if you are not
sure how they work :\)

div#interactive-basics %
  interactive ::
    = Header
    
    * Bullet point
      # One
      # Two
      # Three
    
    * _One underscore for _emphasis
    
    * __Two underscores for __bold
    
    * Link to a site @@ http://google.com
    
    * `code
    
    * Two semicolons comment out
      ;; what you want
         to hide!

    + First name + Last name   + Job
    | Alice      | Lovelace    | Physicist
    | Harold     | Worthington | Banker
        
    & code
       block


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


= Spacing and grouping

Before we tackle anything else let's learn about __spacing and
__grouping.

== Spacing

The spacing between an operator and its operand determine the priority
of the operator. More spacing means a larger operand. To put it
simply:

div#interactive-spacing %
  interactive ::
    __One word is bolded


    __ All the words are bolded


    One word is linked@@index.html


    All the words are linked @@ index.html


Try to play with the spacing above. See what happens if you only put a
space on one side of `[@@].


== Indent

An indented block after an operator belongs to that operator:

div#interactive-indent %
  interactive ::

    * This is
      __ all inside
      the bullet point

    * The following is
      _ all inside
        the emphasis

    *
      You can also put the operator
      alone on its own line.



== Grouping

You can group together any chunk of text by enclosing it in square
brackets (`[[]]).

div#interactive-grouping %
  interactive ::

    * [Brackets do [[[not]]] [show up]]
      unless you escape them: \[\]

    * Emphasis on __one word

    * Emphasis on __[many words]

    * Here is [a link]@@[#grouping]

    * Here is [another link @@ #spacing]

div.spacer1 % []


= HTML Generation

The `[%] operator is used to generate arbitrary HTML nodes, if you
need to. The full syntax looks like this:

& tag.class1.class2#id %
    attribute = value
    child1
    child2
    ...

If there is no tag, the default is `span.

& sup % 2

  img % src = path/to/image

  span.error %
    style = color:red
    An __error occurred!


== `html macro

Alternatively, you can embed HTML directly using one of these two
methods:

& html ::
    <span>x<sup>2</sup></span>

  raw %
    <span>x<sup>2</sup></span>


Sandbox to play with:


div#interactive-html %
  interactive ::
    h3 % Let's generate HTML!
    ol %
      type = i
      li % 2[sup % 2] is 4
      li % 2[sup % 2[sup % 2]] is 16
      li % html :: <em>And so forth...</em>



== Inject CSS



div#interactive-css %
  interactive ::
    === Injecting CSS!
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

    Oranges are [.orange % orange!]
    div.block % HELLO


== Inject JavaScript

Note that This is different from _embedding JavaScript: what I mean by
inject is to write code inside the generated HTML, with script
tags. This is done as follows:

& js :: javascript code

For example,

& js :: console.log("hello")

will print "hello" to the console when you load the page in the
browser. It will do nothing at generation time.


= Variables

If there is a piece of markup you don't want to put in the middle of a
paragraph, for example a long URL for a link, or want to use multiple
times, then variables are for you. It's very simple:

& variable => contents
  ...
  {variable}


For example:

& smith03 => http://some.long-ass.site.com/so/many/levels/smith-besson-2003.pdf
  
  Theropods are a family of dinosaurs which, according to the study
  by Smith@@{smith03}, had very large wings that allowed them to
  fly to the moon.

Better yet... you can define the variable __after it is used, and it
will work anyway!


div#interactive-variables %
  interactive ::
    === Variables
    
    k => __KNOCK!
    {k} {k} {k}
    
    Who's there?
    
    Quaint@@{q} is a language similar to Markdown@@{md} with a dash of
    Haml@@{haml}
    
    q => https://breuleux.github.io/quaint/
    md => http://daringfireball.net/projects/markdown/
    haml => http://haml.info/



= Macros

Simply put, a macro is a reusable template that you assign a name or
an operator to. Macros help with terseness and code reusability,
although abusing them could make your code difficult to read. The
syntax for a macro is:

& [pattern] => template

A pattern is a normal Quaint expression, but any word which is
prefixed with a backslash becomes a _variable. The variable can be
inserted in the template using curly brackets (`{variable}). Here is
an example of a macro someone may write to make superscripts easier:

& [\normal ^ \superscript] => {normal}[sup % {superscript}]
  2^3

Both arguments must be present in order for the macro to work. If
either is absent, for instance `[^2] lacks the `normal argument, the
macro will not be run. You can change this by declaring the argument
as `[\maybe\normal] instead.

Conversely, if you declare the pattern `[[^ \superscript]], Quaint
requires the operator to be prefix, so it won't match, say, `[2 ^ 3],
but it would match `[^ 3] in `[2 [^ 3]].


;; Here's a handy table to help
 you write patterns:

 Y => Yes
 N => No

 + Pattern \/ matches + `[x$y] + `[z$y] + `[x$] + `[$x] +
 | `[\x $ \y]         | {Y}    | {Y}    | {N}   | {N}   |


Sandbox:

;; div#interactive-macros %
  interactive ::
    === Macros

    [\normal ^ \superscript] =>
      {normal}[sup % {superscript}]
    2^3, 2^3^4, 2^3^4^5, it works because operators are right-associative in Quaint.

    css :: .orange { color: orange; }
    [/ \text] => .orange % {text}
    I am a big fan of /oranges and other /[orange food] like /carrots.

    [?? \page] =>
      {page}@@http://wikipedia.org/wiki/{page}
    The [/ ?? orange] is a ??fruit, who would have thought?



= Scripting

Curly brackets switch to "eval mode". They could contain JavaScript,
or Earl Grey, or neither. By default the "eval" used is just a
key-based load/store mechanism. Other scripting languages require
importing a plugin.

Supposing the `quaint-javascript plugin is used, as it is on this
site, then you can effectilvely use JavaScript to help with
generation (looping over data and so on).

div#interactive-scripting %
  interactive ::
    === Scripting
    
    [shout :: \text] => {text.raw().toUpperCase()}
    
    * 2 + 2 = {2 + 2}
    
    * shout :: hello! I don't mean to shout
    
    * {h("b", {}, "Not the most sensible way to do this...")}



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


