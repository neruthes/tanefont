const fs = require('fs/promises');
const fs_old = require('fs');
const { XMLParser } = require('fast-xml-parser');
const child_process = require('child_process');
const { stderr } = require('process');

const BUILD_DIR = process.env.BUILD_DIR;

console.log(XMLParser);
// process.exit(0)


(async function () {
    const TASK = JSON.parse(fs_old.readFileSync(BUILD_DIR + '/task.json').toString());
    const MAP = JSON.parse(fs_old.readFileSync(BUILD_DIR + '/map.json').toString());


    function sanitize_char(input_char) {
        const __mapping = {
            "A": "A",
            '"': '\\"',
            '\\': '\\\\',
            '<': '&lt;',
            '&': '&amp;',
        };
        if (__mapping[input_char] != undefined) {
            return __mapping[input_char]
        } else {
            return input_char;
        };
    };



    async function make_svg(name, text) {
        // <rect id="sizer" x="-150" y="-150" width="300" height="300" fill="#DEAFBEEF" />
        let svg_xml = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="-150 -150 300 300">
    <text x="0" y="0"
        id="text1"
        text-anchor="middle"
        font-family="${TASK.tanefont_task.font_family}"
        font-weight="${TASK.tanefont_task.font_weight}"
        font-style="${TASK.tanefont_task.font_style}"
        fill="currentColor" font-size="150">${sanitize_char(text)}</text>
    </svg>`;

        const real_name = text.codePointAt(0).toString(10);
        const svg_raw_path = BUILD_DIR + '/svgraw/' + name + '.svg';
        const svg_outline_path = BUILD_DIR + '/svgoutline/' + name + '.svg';
        const png_path = svg_outline_path + '.png';
        await fs.writeFile(svg_raw_path, svg_xml);
        await child_process.execFileSync(process.env.svg_outline_convert_bin_path, [svg_raw_path, svg_outline_path]);
        await child_process.execFileSync('rsvg-convert', [svg_outline_path, '-z10', '-o', png_path]);
        await child_process.execFileSync('magick', [png_path, '-trim', '+repage', png_path]);
        const png_info_task = await child_process.execFileSync(`identify`, ['-format', '%W', png_path]);

        const xml = fs_old.readFileSync(svg_outline_path, "utf8");
        const parser = new XMLParser({
            ignoreAttributes: false,
            attributeNamePrefix: "", // so attributes aren't prefixed with "@_"
        });
        const xml_parsed_json = parser.parse(xml);
        // console.log(xml_parsed_json);
        // process.exit(0);
        // const items = xml_parsed_json.svg.path.d;
        // const arr = Array.isArray(items) ? items : [items];
        // const target = arr.find(n => n.id === "text1");
        // if (target) {
        //     console.log(target["path"]);
        // }



        console.log('png_info_task');
        let natural_width = parseFloat(png_info_task.toString()) / 10;
        console.log(natural_width);
        let glyph_path = xml_parsed_json.svg.path.d  || 'M 80 40    L -80 40    L 0 80 Z';
        return {
            cp: text.codePointAt(0),
            l: text,
            w: natural_width,
            g: glyph_path,
        };
    }


    // Main

    let source_arr = MAP.char.slice(0, 9993);
    let entries_list = await Promise.all(source_arr.map(async char => {
        return make_svg(char.name, char.text);
    }));
    // console.log(entries_list);
    let final_map = {};
    entries_list.forEach(obj => {
        final_map[obj.cp.toString()] = obj;
    });
    fs_old.writeFileSync(`${BUILD_DIR}/final.json`, JSON.stringify(final_map, '\t', 4));
})()



