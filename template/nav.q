
meta :: template = boilerplate

div#sidebar %
  div#sidebar-contents %
    store sidebar :: dump!

div#page %
  div#nav-container.container %
    div#nav %
      a#logo-link %
        href = {siteroot}index.html
        div.quaint-word % QUAINT
        img.logo %
          src = {siteroot}assets/quaint-beige.png
          height = 30px
      div.filler % []
      div.navlink % Syntax@@{siteroot}syntax.html
      div.navlink % API@@{siteroot}api.html
      div.navlink % Plugins@@{siteroot}plugins/index.html
      div.navlink % [Try it!]@@{siteroot}tryit.html
      div.navlink % Github@@http://github.com/breuleux/quaint
  {body}
  div#foot-container.container %
    div#foot % []
