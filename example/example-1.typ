#import "tanefont-lib.H.typ": *




```sh
./make.sh task/demo01.toml
typst w example/example-1.typ --root .
```



#set text(font: ("TeX Gyre Heros", "Noto Sans CJK SC"), size: 13pt, kerning: false, overhang: false)

#let font_def_demo01 = json("../build/demo01/final.json")





= (Testing Precise Calibration)

#box(width: 100%, height: 70mm, {
  set text(size: 54mm)
  set text(font: "TeX Gyre Termes")
  let test_word = [Hejrdt] // Change this word
  place(top + left, block({
    show: show-tanefont-use-svg-font(font_def_demo01)
    test_word
  }))
  place(top + left, block({ test_word }))
})








#{
  set text(size: 30pt)
  tanefont__render_string(font_dict: font_def_demo01, "Hello World #$%")
  text(font: "TeX Gyre Termes")[\#\$% Hello World]
  linebreak()
  text(font: "TeX Gyre Termes")[Hello World \#\$%]
}


#set par(justify: true)
#[
  #set text(font: "TeX Gyre Termes")
  #show: show-tanefont-use-svg-font(font_def_demo01)
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
