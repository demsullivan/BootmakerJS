
class BootstrapEditor
        constructor: (config) ->
                @options = config
                @$el = $(@el)
                @rows = @$el.find('div['+@options.prefix+'-row]')
                @cols = @rows.find('div['+@options.prefix+'-col]')
                @editMode = false

        toggleEditMode: () ->
                if not @editMode
                        @editMode = true
                        @rows.addClass(@options.cssPrefix+'-row')
                        @cols.addClass(@options.cssPrefix+'-col')

                        # add handles
                        @cols.resizable(
                                helper: 'ui-resizable-helper'
                                handles: "e, s, w"
                                start: (e, ui) ->
                                        ui.element.data(
                                                snapWidth: ui.originalSize.width
                                                siblings:
                                                        left: ui.element.prev()
                                                        right: ui.element.next()
                                        )
                                stop: (e, ui) ->
                                        ui.element.css(width: '', left: '')
                        )
                        @cols.on('resize', @onCellResize)

                        $('<div/>').addClass(@options.cssPrefix+'-del-cell')
                                .addClass(@options.cssPrefix+'-handle')
                                .html('&times;')
                                .appendTo(@cols)
                                .on('click', @onCellDelete)
                        
                        newRow = document.createElement('div')
                        $(newRow).addClass('row-fluid').attr(@options.prefix+'-ghost-row', '')
                        for x in [1..12]
                                d = document.createElement('div')
                                $(d).addClass('span1')
                                        .addClass(@options.cssPrefix+'-ghost-col')
                                        .attr(@options.prefix+'-ghost-col', '')
                                        .html('')
                                $(newRow).append(d)
                        @$el.append(newRow)
                        @cols.on('dblclick', @onCellDblClick)

                else
                        @editMode = false;
                        @rows.removeClass(@options.cssPrefix+'-row')
                        @cols.removeClass(@options.cssPrefix+'-col')
                        @$el.find('div['+@options.prefix+'-ghost-row]').remove()
                        @cols.resizable('destroy')
                        @cols.off('dblclick')

        onCellDblClick: (e) ->
                $('#pageCellProperties').modal(show: true)
                console.log $(e.currentTarget).attr('bf-page-widget')

        onCellResize: (e, ui) ->
                if ui.originalPosition.left != ui.position.left
                       movement = 'left'
                else if ui.originalSize.width != ui.size.width
                       movement = 'right'

                wChange = ui.element.data('snapWidth') - ui.size.width
                x = ui.element.data('snapWidth') / ui.element.bsSpan()
                # shorthand
                el = ui.element
                sibEl = ui.element.data('siblings')[movement]
                if Math.abs(wChange) > x
                        if wChange > 0
                                if el.bsSpan() > 1
                                        ui.element.bsSpan(ui.element.bsSpan()-1)
                                        ui.element.data('siblings')[movement].bsSpan(ui.element.data('siblings')[movement].bsSpan()+1)
                        else
                                if sibEl.bsSpan() > 1
                                        ui.element.bsSpan(ui.element.bsSpan()+1)
                                        ui.element.data('siblings')[movement].bsSpan(ui.element.data('siblings')[movement].bsSpan()-1)

                        ui.element.data('snapWidth', ui.element.width())

        onCellDelete: (e) ->
                
        onCellOffsetClick: (e) ->
                console.dir e
