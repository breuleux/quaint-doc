
template :: default

meta ::
  title = API

store sidebar ::
  toc::

resources ::
  toc-scroll.js


;; [method \name :: \description] =>
  div.qmethod %
    == {name}
    div.qmethod-description % {description}


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
    "\\a $ \\b": function (engine, vars) {
      var whitespace = vars._wide ? " " : "";
      return [engine.gen(vars.b), engine.gen(vars.a)];
    }
  });

  var html = q.toHTML("{name} {surname} $ hello");
  console.log(html); // "hello Bob Smith"


= QAst

When writing macros and rules, you will have to manipulate QAst
objects. They come with a few methods that are meant to make your life
easier.


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


method sexp(recursive [= true]) ::

  This converts a node to "s-expression" format. To explain it simply:

  & quaint.parse("a + b - c").sexp() ==> ["+", a, ["-", b, c]]

  Note that this erases some information, for example the information
  about the whitespace around the operators, but nonetheless, it can
  be a handy way to navigate the AST.


method args() ::

  This is shorthand for `node.sexp(false).slice(1). In short:

  & quaint.parse("a + b").args() ==> [a, b]


= Engine

Quaint's `Engine encapsulates most functionality. Extensions and
plugins all operate on it.


method plug(plugin, ...) ::
  ...


method gen(node) ::
  ...


method genFromSource(src) ::
  ...


method run(src) ::
  ...


method translate(src, format, options) ::
  ...


method toHTML(src, options) ::
  ...


method toENode(src, options) ::
  ...


method registerMethods(methods) ::
  ...

method registerMacros(macros) ::
  ...

method registerDocuments(documents) ::
  ...

method registerRules(rules) ::
  ...

method clearRules() ::
  ...

method registerPostprocessor(regexp, fn) ::
  ...

method registerResolvers(resolvers) ::
  ...

method eval(text, env) ::
  ...

method setenv(env) ::
  ...

method into(document, value) ::
  ...

method deferred(function) ::
  ...

method redefer(node, function) ::
  ...

method fork() ::

  Create a new Engine from the current one. The new Engine has its own
  scope, meaning that rules and environment variables set on it will
  not affect its parent.





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





