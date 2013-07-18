window.init_lr = ->

    $('.fake').click fake_data
    $('.fit').click process
    fake_data()
    process()

fake_data = ->
    a = parseFloat $('.fake_a').val()
    b = parseFloat $('.fake_b').val()
    r = parseFloat $('.fake_r').val()

    xs = [1..100]
    ys = (round(a*x + b + Math.random() * r, 2) for x in xs)
    $('.xs').val(xs.join(", "))
    $('.ys').val(ys.join(", "))

process = ->
    console.log 'plot'
    xs = $('.xs').val().split(',').map(parseFloat)
    ys = $('.ys').val().split(',').map(parseFloat)

    cost = (xs, ys, h)->
        (Math.pow(h(x) - ys[i], 2) for x, i in xs).sum() / xs.length * 0.5

    # test cost
    # console.log cost([1,2,3], [4,5,6], (x)-> x + 3)

    gradiant = (xs, ys, opt={})->
        a = 0
        b = 0
        alpha = opt.alpha || 0.0003
        m = xs.length

        for i in [1..opt.count]
            h = (x) -> a * x + b

            da = (1 / m) * ((h(x) - ys[i])*x for x,i in xs).sum()
            db = (1 / m) * ((h(x) - ys[i])   for x,i in xs).sum()
            a -= alpha * da
            b -= alpha * db
            console.log a, b, cost(xs, ys, h)

        [a, b]

    # test
    # console.log gradiant([1,2,3], [2.5,3.5,4.5], count: 400)
    # console.log gradiant([1,2,3], [2.5,3.5,4.5], count: 400)

    alpha = parseFloat $('.alpha').val()
    count = parseInt $('.count').val()
    [a, b] = gradiant(xs, ys, count: count, alpha: alpha)

    $('.result_a').text(round(a, 2))
    $('.result_b').text(round(b, 2))
    # [a, b] = [1, 2]
    h = (x) -> a * x + b

    pd = {
        data: ([x, ys[i]] for x, i in xs),
        points: { show: true }
        }
    ph = {
        data: ([x, h(x)] for x in xs)
        lines: { show: true }
        }
    ps = [pd, ph]

    $.plot "#plot_placeholder", ps
