// Set the FPS (FPS), number of stars (N), and the fading of the particles (fading)
var FPS = 60, N = 1500, fading = 0.025
 
// Star Class
class Star {
    constructor(x, y, size, opacity) {
        this.x = x
        this.y = y
        this.size = size
 
        var a = Math.random() * 2 + 0.5, b = Math.random() * 2 + 0.5
        this.xspeed = Math.random() < 0.5 ? a * -1 : a
        this.yspeed = Math.random() < 0.5 ? b * -1 : b
 
        this.r = Math.floor(Math.random() * 256)
        this.g = Math.floor(Math.random() * 256)
        this.b = Math.floor(Math.random() * 256)
 
        this.opacity = opacity
    }
}
 
// Draw Background Stars in a Separate Canvas for Simplicity
var stars = [], fPS = 1000 / FPS
var canvasBG = document.getElementById('background')
var interval = null
 
function drawBG() {
    if(interval) clearInterval(interval)
    var ctxBG = canvasBG.getContext('2d')
    var bgStars = []
 
    canvasBG.width = window.innerWidth
    canvasBG.height = window.innerHeight
 
    for(let i = 0 ; i < 250 ; ++i)
        bgStars[i] = new Star(Math.random() * canvasBG.width, Math.random() * canvasBG.height, Math.random() *2 + 1, 1)
 
    interval = setInterval(() => {
        ctxBG.clearRect(0, 0, canvasBG.width, canvasBG.width)
 
        for(let i = 0 ; i < 250 ; ++i) {
            var bS = bgStars[i]
            ctxBG.fillStyle = `rgba(${bS.r},${bS.g},${bS.b},${Math.random() > 0.05 ? 1 : 0})`
            ctxBG.fillRect(bS.x, bS.y, bS.size, bS.size)
        }
    }, fPS * 20)
}
 
// Draw Particles
var canvas = document.getElementById('starfield')
canvas.width = window.innerWidth
canvas.height = window.innerHeight
 

 
function appendStars() {
    for (let i = 0 ; i < N ; ++i)
        stars[i] = new Star(Math.random() * canvas.width,Math.random() * canvas.height,Math.random() * 2, 0)
}
 
drawBG()
appendStars()
 
window.onresize = () => {
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
    
    drawBG()
    appendStars()
}
 
setInterval(() => {
    var ctx = canvas.getContext( '2d' )
    ctx.clearRect( 0, 0, canvas.width, canvas.height )
 
    for (let i = 0 ; i < N ; ++i) {
        var star = stars[i]
 
        star.x += Math.sin(i) + star.xspeed
        star.y += Math.cos(i) + star.yspeed

        if (star.x > canvas.width || star.x < -star.size || star.y > canvas.height || star.y < -star.size) {
            var randSize = Math.random() * 2 + 1
        }
 
        ctx.fillStyle = `rgba(${star.r}, ${star.g}, ${star.b}, ${star.opacity})`
        ctx.fillRect(star.x, star.y, star.size, star.size )
    }
}, fPS)
