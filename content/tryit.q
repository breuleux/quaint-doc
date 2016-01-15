
template :: nav

meta ::
  title = Try it!


css ::
  @media screen and (min-width: 1300px) {
    html, body {
      height: 100%
    }
    #tryit {
      height: 90%
    }
  }


div#tryit %
  1 &&
    ;; Edit me!
    
    meta ::
      title = My Resume
      author = My Name
    
    = meta::title
    
    Hello, my name is __meta::author and this is meta::title~! I have many skills:
    
    * Pirate skills
      * Eye patch
      * Peg leg
    * _Ninja skills
      css ::
        .invisible { color: transparent; }
      # span.invisible % Stealth!
      # Nunchakus
    * Robot skills
      * Beep! Boop!
    * I can also cook!
      + Meal       + Can I cook it? + How good?
      | Potatoes   | Yes            | Delicious
      | Steak      | Yes            | Rare
      | Egg salad  | You bet!       | Decadent
      | Cheesecake | Yes!!!         | Oh my god
    
    My website is @@{web}. Find me on Google@@http://google.com~! It's easy as 2 + 2 = {2 + 2}!
    
    web => http://my.amazing.website.com
    
    Please embed my `code on your website:
    
    javascript &
      function virus() { alert("AAAAAAAAHHH"); }
    
    @@image:assets/quaint-small.png
