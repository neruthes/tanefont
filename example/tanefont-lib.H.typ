



#let tanefont__svg_for_char(obj, height: 0.97em) = {
  let glyph_width = obj.at("w") * 2
  let base_margin_h = 4.5
  let full_width = base_margin_h + obj.at("w")
  box(inset: (top: -0.073em, bottom: -0.15em, left: 0.00em, right: 0.00em), image(height: height, bytes(
    "<svg xmlns='http://www.w3.org/2000/svg' viewBox='-@SEMIWID -110 @FULLWID 145'>
      <circle cx='0' cy='0' r='100' fill='#ffbb8800' />
    <path d='@PATH_DATA' fill='blue' />
    </svg>"
      .replace(
        "@SEMIWID",
        str(full_width / 2),
      )
      .replace(
        "@FULLWID",
        str(full_width),
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




#let show-tanefont-use-svg-font(font_dict) = {
  let __real_show_rule(doc) = context {
    show regex("[0-9A-Za-z\?\!\.\-=\!@#\$%\^:;\'\"\[\]\{\}\(\)\+\*]+"): it => box(
      tanefont__render_string_fromRegexShowRule(it, font_dict: font_dict),
    )
    doc
  }
  return __real_show_rule
}
