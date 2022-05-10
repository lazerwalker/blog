const { createCanvas, loadImage } = require('canvas')
const {writeFileSync} = require('fs')

const canvas = createCanvas(1200, 630);
const ctx = canvas.getContext('2d');
const { program } = require('commander');
program
    .option('-t, --title <title>', 'The title of the article')
    .option('-d, --date <date>', 'The publish date of the article')
    .option('-f, --filename <filename>', 'The ogimage filename')
    .parse();   

const opts = program.opts()

// Draw cat with lime helmet
// loadImage('./assets/artboard2.png').then((image) => {
// ctx.drawImage(image, 0, 0, 1200, 630);

ctx.beginPath();
ctx.rect(0, 0, 1200, 630);
ctx.fillStyle = '#f0ebeb';
ctx.fill();

ctx.textBaseline = "top";

// Write title
ctx.font = '90px Helvetica'
ctx.fillStyle = '#384869';
wrapText(ctx, opts.title, 80, 80, 1100, 100);

// Write date
ctx.textBaseline = "bottom";

ctx.font = '40px Helvetica'
ctx.fillStyle = '#667fb3';
ctx.fillText("Emilia Lazer-Walker", 80, 500); // TODO: Thread this through via an author property

ctx.font = '40px Helvetica'; 
ctx.fillStyle = '#EBAFA2';
ctx.fillText(opts.date, 80, 555);


const buffer = canvas.toBuffer('image/png')
writeFileSync(opts.filename, buffer)

// })

function wrapText(context, text, x, y, maxWidth, lineHeight) {
    var words = text.split(' ');
    var line = '';

    for (var n = 0; n < words.length; n++) {
        var testLine = line + words[n] + ' ';
        var metrics = context.measureText(testLine);
        var testWidth = metrics.width;
        if (testWidth > maxWidth && n > 0) {
            context.fillText(line, x, y);
            line = words[n] + ' ';
            y += lineHeight;
        } else {
            line = testLine;
        }
    }
    context.fillText(line, x, y);
}