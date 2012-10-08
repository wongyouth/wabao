$('.entry a').click (event)->
  event.preventDefault()
  $.get(
    '/admin/images',
    {item_id: $(this).data('id')},
    (data)->
      $('#item-images').modal()
      $.each(data, (k,v) ->
        $('ul', '#item-images').append("<li><img src='#{v['url']}'></li>")
      )
    'json'
  )
