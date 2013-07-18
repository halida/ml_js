window.init_lr = ->

    plot = ->
        xs = $('.x').text().split(',').map(parseFloat)
        ys = $('.y').text().split(',').map(parseFloat)

        data = []
        for x, i in xs
            data.push([x, ys[i]])

        $.plot "#plot_placeholder",
            [{
            data: data,
            points: { show: true }
            }]

    $('.plot').click plot

    plot()