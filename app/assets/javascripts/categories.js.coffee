toggle = (tr, toggle) ->
  tr.find('.label').toggleClass('label-success', toggle)
  $('.label a', tr).text(if toggle then '显示' else '隐藏')


$(document).on 'click', '.categories .label a', (event)->
  self = this
  cid = $(this).parents('tr').attr('id')
  event.preventDefault()
  $.post $(this).attr('href'), {_method: 'put'}, (data)->
    toggle $(self).parents('tr'), data

    if data # add to #active tab
      $(self).parents('tr').clone().appendTo('#active tbody') if $(self).parents('#all').length > 0
    else
      # remove itself if in active tab
      if $(self).parents('#active').length > 0
        $(self).parents('tr').remove()
        toggle $("#" + cid, '#all'), data
      else
        $("#" + cid, '#active').remove()
  , 'json'

.on 'click', '.tabbale a', (event) ->
  event.preventDefault()
  $(this).tab('show')

$(".tabbale a:first").tab('show')
