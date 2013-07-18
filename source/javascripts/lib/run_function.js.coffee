window.run_functions = (body)->
    body = 'body' unless body?
    body = $(body)

    body.find('input[data-function]').each ->
        self = $(this)
        name = self.data('function')
        func = window[name] || gdlib[name]
        unless func
            console.log "error, cannot found function: ", name
            return
        func(self.data())
