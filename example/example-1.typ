#context [
  ```sh
  ./make.sh task/demo01.toml
  typst w example/example-1.typ --root .
  ```

  #set text(font: ("TeX Gyre Heros", "Noto Sans CJK SC"), size: 13pt, kerning: false)

  #let font_def_demo01 = json("../build/demo01/final.json")


  #let tanefont__svg_for_char(obj, height: 1em) = {
    let glyph_width = obj.at("w") * 2
    box(inset: (bottom: -0.2em), image(height: height, bytes(
      "<svg xmlns='http://www.w3.org/2000/svg' viewBox='-@SEMIWID -120 @FULLWID 145'>
      <circle cx='0' cy='0' r='100' fill='#ffbb8800' />
    <path d='@PATH_DATA' fill='blue' />
    </svg>"
        .replace(
          "@SEMIWID",
          str(obj.at("w") * 0.57000),
        )
        .replace(
          "@FULLWID",
          str(obj.at("w") * 2 * 0.57000),
        )
        .replace(
          "@PATH_DATA",
          obj.at("g"),
        ),
    )))
  }
  #let tanefont__render_char(it, font_dict: (:)) = {
    if it == " " {
      return [ ]
    }
    let cp_int = it.codepoints().map(str.to-unicode).first()
    if font_dict.at(str(cp_int), default: none) != none {
      tanefont__svg_for_char(font_dict.at(str(cp_int)))
    } else {
      it
    }
  }
  #let tanefont__render_string(input_str, font_dict: (:)) = {
    input_str.clusters().map(it => tanefont__render_char(it, font_dict: font_dict)).join()
  }
  #let tanefont__render_string_fromRegexShowRule(input_str, font_dict: (:)) = {
    input_str.text.clusters().map(it => tanefont__render_char(it, font_dict: font_dict)).join()
  }


  #let show_rule_use_svg_font(font_dict) = {
    let __real_show_rule(doc) = context {
      show regex("[0-9A-Za-z]+"): it => box(tanefont__render_string_fromRegexShowRule(it, font_dict: font_dict))
      doc
    }
    return __real_show_rule
  }




  #{
    set text(size: 30pt)
    tanefont__render_string(font_dict: font_def_demo01, "Hello World #$%")
    text(font: "TeX Gyre Termes")[\#\$% Hello World]
    linebreak()
    text(font: "TeX Gyre Termes")[Hello World \#\$%]
  }


  #set par(justify: true)
  #[
    #show: show_rule_use_svg_font(font_def_demo01)
    Using a show rule to render these words... \
    Hello World #lorem(55)
  ]

  #[
    And using a normal font... \
    Hello World #lorem(55)
  ]

  #font_def_demo01




]
