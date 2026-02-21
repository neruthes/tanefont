const fs = require('fs');

const BUILD_DIR = (process.argv[2] + '/').replace(/\/+$/, '');

console.log(`[INFO] Combining glyphs and kerning table for ${BUILD_DIR}/final.json`);


let task_obj = JSON.parse(fs.readFileSync(BUILD_DIR + '/task.json').toString());
let glyphs_obj = JSON.parse(fs.readFileSync(BUILD_DIR + '/glyphs.json').toString());
// glyphs_obj.kerning_table = task_obj.kerning_table;

fs.writeFileSync(BUILD_DIR + '/final.json', JSON.stringify({
    glyphs: glyphs_obj,
    kerning_table: task_obj.kerning_table,
}, '\t', 4));
