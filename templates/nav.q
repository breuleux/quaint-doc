template :: @minimal
[[[
nav ::
  * inherit#logo-link %
      [div.quaint-word % QUAINT][@@@ image:assets/quaint-beige.png] @@@ index.html
nav ::
  ul % li.spacer %
nav main|mobile-menu ::
  * Syntax@@@syntax.html
  * Usage@@@usage.html
  * API@@@api.html
  * Plugins@@@plugins/index.html
    * List@@@plugins/index.html
    * Contributing@@@plugins/write.html
  * [Try it!]@@@tryit.html
  * Github@@http://github.com/breuleux/quaint
nav mobile ::
  ul % li.spacer %
nav mobile ::
  * inherit#logo-link %
      [div.quaint-word % QUAINT] @@@ index.html
nav mobile ::
  ul % li.spacer %
nav mobile ::
  * inherit#logo-link %
      [@@@ image:assets/quaint-beige.png] @@@ index.html
]]]
lnnav :: dump!
{body}
