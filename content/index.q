
template :: nav

meta ::
  title = Quaint

resources ::
  edit!
  /resources/owl/owl.carousel.css
  /resources/owl/owl.theme.css
  /resources/owl/owl.transitions.css
  /resources/owl/jquery-1.9.1.min.js
  /resources/owl/owl.carousel.js

[\title !!! \description] =>
  div %
    div.title % {title}
    div.description % {description}

div#main-container.container % [

div#present-container %
  div#present %
    img.logo %
       src = {siteroot}assets/quaint-beige.png
       height = 80px
    div.quaint-word % QUAINT
    div.quaint-description %
       _[the extensible markup language]
    div.selling-points %
      Terse !!!
        A small set of intuitive operators that
        get out of your way.
      Complete !!!
        Format lists and tables, highlight code, build HTML.
      Powerful !!!
        Embed JavaScript, simplify your workflow with macros,
        generate indexes and tables of contents.
      Extensible !!!
        Plugins can be written in JavaScript in a matter of
        minutes. Macros can be written in a matter of seconds.

div#main % [

#comparison .owl-carousel .owl-theme %
  .comparison %
    div %
      .lang % HTML
      &
        <dl>
          <dt>Manganese</dt>
          <dd>The 25th element</dd>
          <dt>Football</dt>
          <dd>A <strong>sport</strong></dd>
        </dl>
    div %
      .lang % Quaint
      &
        dl %
          dt % Manganese
          dd % The 25th element
          dt % Football
          dd % A __sport
  .comparison %
    div %
      .lang % Markdown
      &
        some markdown
    div %
      .lang % Quaint
      &
        some quaint

js ::
  $(document).ready(function() {
    $("#comparison").owlCarousel({
      // navigation: true,
      singleItem: true,
      transitionStyle: "fade"
    });
  });


div.spacer1 % []

div#instructions %
  50 &&
    ;; Edit me!!!
    


    = What is it?
    
    __Quaint is a _[markup language] that you can use to write documents. It is similar to `Markdown, but it is [strong % more powerful] and __[more extensible].
    


    = Install
    
    To install __Quaint globally:
    
    bash & npm install quaint -g
    
    This will install the `quaint command on your system. Then you can convert quaint markup to HTML! See usage@@usage.html.
    
    ;\)



    = Learn
    
    * Learn the syntax! @@
        /quaint/syntax.html
    * JavaScript API @@ /quaint/api.html
    * Check out the plugins @@
        /quaint/plugins/index.html
    


    div %
      style =
        text-align:center;
        margin-top:50px
      @@image:assets/quaint-small.png

]

div.spacer1 % []

]
