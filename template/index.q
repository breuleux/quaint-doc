
meta :: template = nav

div#present-container %
  div#present %
    img#logo %
       src = {siteroot}assets/quaint.png
       height = 80px

div#main-container.container %
  div#main %
    {body}
