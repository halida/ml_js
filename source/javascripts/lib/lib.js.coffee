Array.prototype.sum = ->
    this.reduce(  (j, k)-> j+k )

window.round = (v, r)->
    c = Math.pow(10, r)
    Math.round(v*c)/c