#import "tanefont-lib.H.typ": *




```sh
./make.sh task/demo01.toml
typst w example/example-1.typ --root .
```



#set text(font: ("TeX Gyre Heros", "Noto Sans CJK SC"), size: 13pt, kerning: true, overhang: false)

#let font_def_demo01 = json("../build/demo01/final.json")




#let __default_kerning_table = (
  "M::i": 5,
  "H::e": 10,
  "W::o": -69,
  "a::s": 25,
  "d::o": 15,
  "d::t": -10,
  "e::l": 10,
  "i::d": 9,
  "i::t": -5,
  "j::r": -30,
  "l::l": 10,
  "l::o": 20,
  "o::r": -5,
  "o::s": 45,
  "p::o": 15,
  "r::d": -5,
  "r::i": 10,
  "r::l": -30,
  "u::s": 29,
  "s::i": 44,
  "s::s": 59,
  "t::a": -5,
)

= (Testing Precise Calibration)
#box(width: 100%, height: 70mm, {
  set text(size: 54mm)
  set text(font: "TeX Gyre Termes")
  let test_word = [World] // Change this word
  place(top + left, block({
    show: show-tanefont-use-svg-font(font_dict: font_def_demo01, kerning_table: __default_kerning_table)
    test_word
  }))
  place(top + left, block({ test_word }))
})








#{
  set text(size: 30pt)
  tanefont__render_string(font_dict: font_def_demo01, kerning_table: __default_kerning_table, "Hello World #$%")
  text(font: "TeX Gyre Termes")[\#\$% Hello World]
  linebreak()
  text(font: "TeX Gyre Termes")[Hello World \#\$%]
}


#set par(justify: true)
#[
  #set text(font: "TeX Gyre Termes")
  #show: show-tanefont-use-svg-font(font_dict: font_def_demo01, kerning_table: __default_kerning_table)
  Using a show rule to render these words... \
  Hello World #lorem(55)
]

#[
  #set text(font: "TeX Gyre Termes")
  And using a normal font... \
  Hello World #lorem(55)
]


#set text(size: 9pt)
#font_def_demo01


// #pagebreak()
