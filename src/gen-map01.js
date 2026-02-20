const fs = require('fs');



let OUTPUT_STREAM = `# This is an automatically generated mapping file. Do not edit.
#       $   node src/gen-map01.js

`;


function sanitize_char(input_char) {
    const __mapping = {
        "A": "A",
        '"': '\\"',
        '\\': '\\\\',
        '<': '&lt;',
    };
    if (__mapping[input_char] != undefined) {
        return __mapping[input_char]
    } else {
        return input_char;
    };
};

function make_item(item_code) {
    return `[[char]]
name = "0x${item_code.toString(16)}"
text = "${sanitize_char(String.fromCodePoint(item_code))}"
\n`;
};





for (let item_code = 0x23; item_code < 0x7F; item_code++) {
    OUTPUT_STREAM += make_item(item_code);
};


// console.log(OUTPUT_STREAM);

fs.writeFileSync('assets/map01.toml', OUTPUT_STREAM)
