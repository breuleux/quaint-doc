
meta :: template = boilerplate

div#nav-container.container %
  div#nav %
    div.quaint-word % QUAINT
    img.logo %
      src = {siteroot}assets/quaint-beige.png
      height = 30px
    div.filler % []
    div.navlink % Syntax
    div.navlink % API
    div.navlink % Try it!
    div.navlink % Github
{body}

div#foot-container.container %
  div#foot %
    Footer (template/nav.q)
