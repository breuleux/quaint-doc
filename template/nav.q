template :: @minimal
nav ::
  * a#logo-link %
      href = {documents.meta.getRaw{"siteRoot"}}/index.html
      div.quaint-word % QUAINT
      img.logo %
        src = {documents.meta.getRaw{"siteRoot"}}/assets/quaint-beige.png
        height = 30px
nav ::
  ul % li.spacer %
nav ::
  * Syntax@@@syntax.html
  * Usage@@@usage.html
  * API@@@api.html
  * Plugins@@@plugins/index.html
    * List@@@plugins/index.html
    * Contributing@@@plugins/write.html
  * [Try it!]@@@tryit.html
  * Github@@http://github.com/breuleux/quaint
div#sidebar %
  div#sidebar-contents %
    store sidebar :: dump!
lnnav :: dump!
{body}
