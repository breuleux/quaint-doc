
template :: nav

meta ::
  title = Quaint

resources ::
  resources/owl/owl.carousel.css
  resources/owl/owl.theme.css
  resources/owl/owl.transitions.css
  resources/owl/jquery-1.9.1.min.js
  resources/owl/owl.carousel.js

[\title !!! \description] =>
  div %
    div.title % {title}
    div.description % {description}

div#main-container % [

div#present-container %
  div#present.container %
    img.logo %
       src = {documents.meta.getRaw{"siteRoot"}}assets/quaint-beige.png
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

htmlVsQuaint =>
  .comparison %
    div %
      .lang % HTML
      & <dl>
          <dt>Manganese</dt>
          <dd>The 25th element</dd>
          <dt>Football</dt>
          <dd>A <strong>sport</strong></dd>
        </dl>
    div %
      .lang % Quaint
      & dl %
          dt % Manganese
          dd % The 25th element
          dt % Football
          dd % A __sport

htmlVsQuaint2 =>
  .comparison %
    div %
      .lang % HTML
      & <div id="page">
          <div class="post">
            <div class="author">
              Albert Einstein
            </div>
            <div class="postbody">
              I fart like <span class="yellow">
              thunder</span>.
            </div>
          </div>
        </div>
    div %
      .lang % Quaint
      & #page %
          .post %
            .author %
              Albert Einstein
            .postbody %
              I fart like [span.yellow % thunder].

mdVsQuaint =>
  .comparison %
    div %
      .lang % Markdown
      &
        Check out **these** packages!
        * [marked][0]
        * [earlgrey][1]
        * [gulp][2]
        * [express][3]

        [0](//npmjs.com/package/markdown)
        [1](//npmjs.com/package/earlgrey)
        [2](//npmjs.com/package/gulp)
        [3](//npmjs.com/package/express)
    div %
      .lang % Quaint
      &
        [npm: \name] =>
          {name} @@ //npmjs.com/package/{name}

        Check out __these packages!
        * npm: quaint
        * npm: earlgrey
        * npm: gulp
        * npm: express

mdVsQuaint2 =>
  .comparison %
    div %
      .lang % Markdown
      &
        There are many wild animals in
        [Canada](//wikipedia.org/wiki/Canada).
        They include
        [bears](//wikipedia.org/wiki/Bear),
        [moose](//wikipedia.org/wiki/Moose) and
        [beavers](//wikipedia.org/wiki/Beaver).
    div %
      .lang % Quaint
      &
        [? \name] =>
          {name} @@ //wikipedia.org/wiki/{name}

        There are many wild animals in ?Canada. They include ?bears, ?moose and ?beavers.


#comparison .owl-carousel .owl-theme %
  {mdVsQuaint2}
  {mdVsQuaint}
  {htmlVsQuaint2}
;;  {htmlVsQuaint}

js ::
  $(document).ready(function() {
    $("#comparison").owlCarousel({
      // navigation: true,
      autoPlay: 8000,
      stopOnHover: true,
      mouseDrag: false,
      singleItem: true,
      transitionStyle: "goDown"
    });
  });


div#main.container % [

 div#instructions %
  50 &&
    ;; Edit me!!!
    
    = What is it?
    
    __Quaint is a _[markup language] that you can use to write documents. It is similar to `Markdown, but it is [strong % more powerful] and __[more extensible].
    
    = Install
    
    To install __Quaint globally:
    
    bash & npm install quaint -g
    
    This will install the `quaint command on your system. Then you can convert quaint markup to HTML! See usage@@usage.html.
    
    = Learn

    * Learn the syntax! @@ syntax.html
    * JavaScript API @@ api.html
    * Check out the plugins @@
        plugins/index.html

    = Contribute

    * Write plugins! @@ plugins/write.html
    
    div %
      style =
        text-align:center;
        margin-top:50px
      @@image:assets/quaint-small.png

]

div.spacer1 % []

]
