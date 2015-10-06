
template :: default

meta ::
  title = API

store sidebar ::
  toc::

resources ::
  toc-scroll.js


= Overview

Install `quaint locally in order to use its programmatic interface:

bash &
  npm install quaint

The basic interface looks like this:

javascript &
  var quaint = require("quaint");
  var html = quaint.toHTML("Some __Quaint markup!");
  console.log(html);

If you want more/different functionality, you can install plugins
locally and make your own quaint engine:

javascript &
  var quaint = require("quaint");
  var qjs = require("quaint-javascript");
  var qhl = require("quaint-highlight");

  // Instantiate with plugins
  var q = quaint(qjs, qhl({"default": "python"}));

  // Set some environment variables
  q.setenv({name: "Bob", surname: "Smith"});

  // Add a rule
  q.registerRules({
    "\\a <=> \\b": function (engine, vars) {
      var whitespace = vars._wide ? " " : "";
      return [engine.gen(vars.b), whitespace, engine.gen(vars.a)];
    }
  });

  var html = q.toHTML("{name} {surname} <=> hello");
  console.log(html); // "hello Bob Smith"


= Interface

There are three classes of objects you will interact with when
extending Quaint and writing plugins:

* The __[`Engine] contains all of Quaint's rules, macros, and so on,
  and it controls generation.

* __[`QAst] nodes represent parsed segments of Quaint. You can get the
  source code behind them easily with `raw() or extract its structure
  with `extract(). There are three types of nodes:
  * __[`Text] is a leaf that represents a word
  * __[`Oper] is a leaf that represents an operator
  * __[`Seq] is an inner node

* Rules are given an `Engine and `QAst arguments, and they must return
  an __[`ENode], an array or a string (null is ignored and any other
  type is converted to a string). ENodes are a lightweight structure
  with tags, properties and children and HTML can easily be generated
  from them.

Now, if you were to add a rule to Quaint it might look like this:

javascript &
  engine = quaint();
  engine.registerRules({
    "\\a <=> \\b": function (engine, vars) {
      var whitespace = vars._wide ? " " : "";
      children = [engine.gen(vars.b)
                  whitespace
                  engine.gen(vars.a)];
      return quaint.h("div.swapped", {}, children);
    }
  });

Salient points:

* `quaint() returns an `Engine
* A rule is registered on an `Engine
* A rule defines _parameters marked with a backslash
  (but you need to
  put two because it's in a JavaScript string).
* When triggered, a rule receives the `Engine and an object with the
  parameters (we call it `vars here).
* Each of the rule's named parameters is a field in `vars
* `vars has special fields:
  * `vars._node contains the whole node that the rule matched
  * `vars._op contains the operator token
  * `vars._wide, (the only one shown), is true if the rule was applied
    to `[x <=> y] (there is whitespace around `[<=>], so it's "wide")
    and false if it was applied to `[x<=>y] (no whitespace around it).
* `vars.a and `vars.b are `QAst instances.
* You process these instances recursively by calling `engine.gen on them.
* The `quaint.h function produces an `ENode.
* That `ENode will be transformed in the string `[<div class="swapped">...]


= QAst

`QAst is the class all the nodes in Quaint's syntax tree are an
instance of.

== Tree structure

That tree is in the same order as the source, which is to say, if you
iterate over a `QAst tree depth first and print out the the leaves as
you encounter them, you recover the original source code exactly. This
is not literally what you get, but to put it simply, the parser
returns something like this:

& quaint.parse("(x + y) - z")
  => [["", "(", ["x", " + ", "y"], ")", ""], " - ", "z"]

The whitespace is taken up by the operators whenever possible so that
you don't have to worry about leading or trailing whitespace on the
operands.

Note that there are indeed empty nodes before and after the
parentheses. This is useful because it preserves the invariant that
every element at an _odd index is an operator (an `Oper leaf).

== Useful methods

[@#@ \\x] => [code % {x}] @@ #{x}

* @#@raw extracts the source code for the node. Very useful.
* @#@empty tells you whether a node is only whitespace.
* @#@extract lets you apply rules to a node directly.
* @#@shed, @#@shedAll and @#@shedIndent removes outer brackets or indent.




method args() ::

  This is shorthand for `node.sexp(false).slice(1). In short:

  & quaint.parse("a + b").args() ==> [a, b]


method collapse() ::

  Flatten a node with all its children on the right side that have the
  same operator. Basically:

  & quaint.parse("a + b + c + d").collapse() ==> [a, b, c, d]

  javascript &
    q.registerMacros({
        sum: function (engine, xs) {
            return xs.collapse().reduce(function (a, b) {
                return a + parseFloat(b.raw());
            }, 0)
        }
    });
    q.toHTML("sum :: 1 + 20 + 34"); // 55
    q.toHTML("sum :: 1 / 20 / 34"); // 55 as well, since we don't actually check 
                                    // what operator this is


method empty() ::

  Returns true if the node is whitespace. That is to say, `node.empty()
  is equivalent to `[node.raw().trim() === ""].


method extract(rules) ::

  This matches a node against a list of possible rule patterns and
  returns the first one that matches.

  If a rule matches, the variables declared in the rule are set in the
  returned object. If no rules match, the return value is false.

  javascript &
    q.registerMacros({
        addition: function (engine, x) {
            var r = x.extract("\\x + \\y");
            if (r)
               return parseFloat(r.x.raw()) + parseFloat(r.y.raw());
            else
               return "NO"
        }
    });
    q.toHTML("[addition :: 12 + 3] [addition :: hello]"); // 15 NO

  If there are several rules, they can either be given as multiple
  arguments to `extract or as a dictionary that maps a name to a
  rule. The `[_which] field of the returned object will contain the
  index or the name of the matching rule.

  javascript &
    q.registerMacros({
        check: function (engine, x) {
            [x.extract("\\x + \\y - \\z", "\\z")._which
             x.extract({add: "\\x + \\y", other: "\\z"})._which]
        }
    });
    q.toHTML("[check :: 12 + 3 - 7] [check :: hello]"); // 0add 1other

  Patterns can be as complex as you want, but keep in mind that all
  operators in Quaint are __right-associative.


method raw() ::

  `node.raw() returns the source code that produced the node as a
  string. 

  javascript &
    q.registerMacros({
        shout: function (engine, text) {
            return text.raw().toUpperCase();
        }
    });
    q.toHTML("shout :: hello!"); // HELLO!


method sexp(recursive [= true]) ::

  This converts a node to "s-expression" format. To explain it simply:

  & quaint.parse("a + b - c").sexp() ==> ["+", a, ["-", b, c]]

  Note that this erases some information, for example the information
  about the whitespace around the operators, but nonetheless, it can
  be a handy way to navigate the AST.


method shed(n [= 1]) ::

  The `shed method removes one (or `n) outer layer of square grouping
  brackets `[[]]. If there are no outer brackets, this does nothing
  and returns the node itself.

  javascript &
    q.registerMacros({
        shout2: function (engine, text) {
            return text.shed().raw().toUpperCase();
        }
    });
    q.toHTML("shout2 :: [[[hello friends!]]]"); // [[HELLO FRIENDS!]]


method shedAll() ::

  This is the same as `shed(Infinity): it sheds all outer square
  brackets.

  Note that Quaint does not display brackets by default, so you only
  really need to do this if you need to dig inside a node, either
  because you want to get the string value of what's inside, or
  because you want to extract fields using a pattern and the brackets
  would get in your way.

  javascript &
    q.registerMacros({
        shout3: function (engine, text) {
            return text.shedAll().raw().toUpperCase();
        }
    });
    q.toHTML("shout3 :: [[[hello friends!]]]"); // HELLO FRIENDS!


method shedIndent() ::

  An indented block is a special node in Quaint (the `[I( )I]
  operator, to be exact). It is sometimes useful to shed that node so
  that we can better get to what's inside it.


method statements() ::

  The `statements method transforms a newline-separated "body" into a
  list of statements. This is handy if you want to implement something
  like the `meta macro, or simply apply a rule to every element in a
  list.

  javascript &
    q.registerMacros({
        greet: function (engine, body) {
            body.statements().map(function (person) {
                return ["Hello ", engine.gen(person)]
            })
        }
    });
    q.toHTML("greet ::\n Alice\n Bob\n Charlie");
    // Hello AliceHello BobHello Charlie




= Engine

Quaint's `Engine encapsulates most functionality. Extensions and
plugins all operate on it.


== Notable methods

There are two groups of notable methods, the user-facing methods and
the plugin-facing methods:

=== User-facing

* @#@toHTML transforms a string to HTML.

* @#@toENode transforms a string to ENode, which is the intermediate
  format before HTML conversion.

=== Plugin-facing

* @#@gen transforms a `QAst instance into an `ENode using the defined
  rules. You have the responsibility to call it recursively in your
  own rules.

* @#@registerRules, @#@registerMacros, etc. let you register
  extensions to extend the `Engine's functionality.

* @#@setenv sets variables for the embedded language.

* @#@into generates data into different "documents". Such nodes will
  disappear from the output, but...

* @#@deferred lets you generate something after everything else was
  generated. This is usually used to format the documents that were
  generated @#@into.


method deferred(function) ::

  By using `deferred you can delay the generation of the node at this
  position. Typically this is because you may need information that is
  located below, and you need to let the engine fill it in. For
  example, a table of contents needs to know about all the sections in
  the document, but these sections come later, so it will use
  `deferred.

  The function given to `deferred must take two arguments, `path and
  `documents. `path is a unique identifier for the location of the
  node in the source. `documents is the same as `engine.documents, and
  it contains various "documents" such as a sections document, a meta
  document, and so on.

  Consider the following macro that gets the title meta-information
  from the `meta document:

  javascript &
    q.registerMacros({
        title: function (engine, body) {
            engine.deferred(function (path, docs) {
                return docs.meta.get("title");
            });
        }
    });
    q.toHTML("[title ::][meta :: title = hello]"); // hello

  Even though the meta-information is set _after the macro call,
  `deferred waits for it to be set before executing the function.

  Now, you may wonder what happens if the title was set by another
  deferred, and this other deferred came after. The answer is that it
  will still work, because __[Quaint may execute a deferred multiple
  times]. Essentially, Quaint detects what documents are consulted by
  a deferred, and it executes it again if these change, until an
  equilibrium is achieved, or a maximum number of iterations is
  reached (currently that maximum is 10, so buggy or ill-behaved
  deferred can only do limited damage).


method eval(expr, env) ::

  Evaluate an expression using the current evaluator (which may be a
  key/value store, or a JavaScript evaluator, or an Earl Grey
  evaluator, etc.) Optionally the method takes an environment
  parameter (variables to define for the evaluation).

  javascript &
    q.plug(quaint-javascript);
    q.eval("2 + 2") // 4
    q.eval("a + b", {"a": 1, "b": 8}) // 9

  Environment variables may also be set with [`setenv @@ #setenv].


method fork() ::

  Create a new `Engine from the current one. The new `Engine has its
  own scope, meaning that rules and environment variables set on it
  will not affect its parent.


method gen(node) ::

  Generate an `ENode from a `QAst using all the [`Engine]'s rules and
  macros. Unlike @#@toENode, however, `gen does not evaluate
  [`Deferred @@ #deferred] nodes.

  `gen is the method that should be used to recursively process nodes
  in a rule or macro (if such processing is desired).


method genFromSource(src) ::

  This is just like @#@gen, but instead of taking a `QAst as input, it
  takes a source string, which it parses and then processes. It is
  basically equivalent to:

  & node.genFromSource(x) <=> node.gen(quaint.parse(x))


method into(document, value) ::

  `into lets you generate data into a "document" which isn't the main
  one. For instance, `[meta :: title = hello] generates a key/value
  pair in the `meta document, whereas a header may generate
  information in the `sections document, an error handler may register
  the error into the `errors document, and so on.

  The result of this operation will not show in the output, unless a
  different operation decides to display the stashed value (for
  example, headers stash information into `sections, and
  [`toc @@ syntax.html#toc] extracts it to display a table of contents).

  Also, note that `into is __declarative, it doesn't actually have
  side-effects when called. Therefore, even though the return value of
  `into is not displayed, a plugin needs to return it, or embed it in
  the return value, in order for it to do anything.

  Extracting values stashed in sub-documents with `into is typically
  done with [`deferred @@ #deferred]. This ensures the extraction
  operates after all the stashing is done.


method plug(plugin, ...) ::

  Execute one or more plugins on the `Engine.


method redefer(node, function) ::

  If a macro or rule wishes to execute a [`deferred @@ #deferred] to
  inspect its contents, for instance to implement a conditional,
  `redefer will take a generated result (which may be an `ENode, a
  string, a `Deferred, and so on) and a function, and it will execute
  the function on the node either immediately (if the node is not a
  `Deferred) or when the `Deferred is executed.

  For example:

  javascript &
    q.registerMacros({
        "if": function (engine, cond, body) {
            return engine.redefer(engine.gen(cond), function (result) {
                if (result)
                    return engine.gen(body)
                else
                    return ""
            });
        }
    });
    q.toHTML("[if meta::x :: hi][meta :: x: true]"); // hi

  Thanks to `redefer we can ensure that the condition is computed
  after the meta-information is set. In fact, `redefer is more or less
  required for it to work.

  Just like `deferred, __[`redefer may be executed multiple
  times]. For instance, it is possible that as a result of the order
  in which some operations are done, the value of a condition changes,
  and then the `if will be recomputed.


method registerDocuments(documents) ::

  Register new documents. You would use this if you wanted to create a
  `references document for bibliographies, or a `links document that
  gathers all links on the page, and so on.

  There are two document types you may instantiate:

  javascript &
    q.registerDocuments({
        references: quaint.MapDocument(),
        links: quaint.SeqDocument()
    });


method registerMacros(macros) ::

  A macro named `m is meant to be used as `[m :: body] or
  `[m arg :: body], or even `[m arg1 arg2 :: body], and so on.

  javascript &
    q.registerMacros({
        ignore: function (engine, body) {
            return "";
        }
    });
    q.toHTML("1[ignore :: 2]3"); // 13

  The first argument is always the `Engine. The last is always the
  body.


method registerMethods(methods) ::

  The object given as `methods is merged with the `Engine, in other
  words, this adds methods to the `Engine.

  javascript &
    engine.registerMethods({berry: function () { return "juicy!"; }});
    engine.berry()  // "juicy!"


method registerResolvers(resolvers) ::

  A resolver is a function that takes a filename or symbol of sorts,
  and returns a string corresponding to the contents. If, for
  instance, you have the Quaint statement:

  & template :: xyz

  This will resolve `xyz by calling `engine.resolvers.template("xyz").
  Each macro that may import files has a resolver, and there is a
  default resolver as well (which just assumes the path is relative to
  the current working directory).

  & include :: file.json   ;; engine.resolvers.include("file.json")
  & format file.json ::    ;; engine.resolvers.format("file.json")
  & plugin xyz ::          ;; engine.resolvers.plugin("xyz")

  Note that the latter will never use the default resolver, since it
  seeks a package and not a file.


method registerRules(rules) ::

  Define a new rule. A rule is a pattern where certain words are made
  into variables by prefixing them with a backslash. Of course, when
  defining such a pattern in a programming language like JavaScript,
  one ought to use two backslashes.

  javascript &
    q.registerRules({
        "$\\x": function (engine, vars) {
            return [engine.gen(vars.x), " dollars"];
        }
    });
    q.toHTML("I give you $100"); // I give you 100 dollars


method setenv(env) ::

  Set variables for use by the current evaluator inside curly
  braces. The syntax for the evaluator depends on the plugins used.

  javascript &
    q.plug(quaint-javascript);
    q.setenv({"a": 11, "b": 22});
    q.toHTML("{a + b}"); // 33


method toENode(src, options) ::

  Generate an `ENode from text.
  Same as `translate(src, "enode", options).
  See @#@translate for the options.


method toHTML(src, options) ::

  Generate `HTML from text.
  Same as `translate(src, "html", options).
  See @#@translate for the options.


method translate(src, format, options) ::

  Execute Quaint on the source text and return something in the
  desired format.

  Available formats:
  * `"enode"
  * `"html"

  Options:
  * `paragraph: wrap the result in a paragraph tag (default false)
  * `noTemplate: avoid executing templates (default false)





;; [

= Examples

Calculator example:

javascript &
    function calc(node) {
        var r = node.extract({
            bra: "(\\a)",
            add: "\\a + \\b",
            sub: "\\a - \\b",
            mul: "\\a * \\b",
            div: "\\a / \\b",
            num: "\\a"
        });
        switch (r._which) {
        case "bra": return calc(r.a);
        case "add": return calc(r.a) + calc(r.b);
        case "sub": return calc(r.a) - calc(r.b);
        case "mul": return calc(r.a) * calc(r.b);
        case "div": return calc(r.a) / calc(r.b);
        case "num": return parseFloat(r.a.raw());
        }
    }
    q.registerMacros({
        calculate: function (engine, node) { return String(calc(node)); }
    });
    
    // Note that this returns 14, not 10, because Quaint's operators are right-associative
    var html = q.toHTML("calculate :: 2 * 3 + 4")
]

