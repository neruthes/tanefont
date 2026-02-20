#context [
  ```sh
  ./make.sh task/demo01.toml
  typst w example/example-1.typ --root .
  ```

  #set text(font: ("TeX Gyre Heros", "Noto Sans CJK SC"), size: 13pt, kerning: false)

  #let tanefont_json = json("../build/demo01/final.json")

  // #tanefont_json


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
  #let tanefont__render_char(it) = {
    if it == " " {
      return [ ]
    }
    let cp_int = it.codepoints().map(str.to-unicode).first()
    if tanefont_json.at(str(cp_int), default: none) != none {
      // [(!)]
      tanefont__svg_for_char(tanefont_json.at(str(cp_int)))
    } else {
      it
      // it.codepoints().join()
    }
  }
  #let tanefont__render_string(input_str) = {
    input_str.clusters().map(tanefont__render_char).join()
    // [#input_str.clusters().map(it => str(it.codepoints().map(str.to-unicode).first()))]
  }




  #{
    set text(size: 30pt)
    tanefont__render_string("Hello World #$%")
    text(font: "TeX Gyre Termes")[\#\$% Hello World]
    linebreak()
    text(font: "TeX Gyre Termes")[Hello World \#\$%]
  }

  #tanefont_json




]
