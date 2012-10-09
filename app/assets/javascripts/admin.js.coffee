$('.entry a').click (event)->
  event.preventDefault()
  $.get(
    '/admin/images',
    {item_id: $(this).data('id')},
    (data)->
      $('#item-images').modal()
      $('#item-images').append("<div id='item-info' style='display: none' />")
      $('#item-info').data('id'         , $(this).data('id'))
      $('#item-info').data('price'      , $(this).data('price'))
      $('#item-info').data('commission' , $(this).data('commission'))
      $('#item-info').data('volume'     , $(this).data('volume'))
      $('#item-info').data('nick'       , $(this).data('nick'))
      $('#item-info').data('title'      , $(this).data('title'))
      $('#item-info').data('click_url'  , $(this).data('click_url'))
      $('#item-images').append("<ul />")
      $.each(data, (k,v) ->
        $('ul', '#item-images').append("<li><a href='#'><img src='#{v['url']}' /></a></li>")
      )
    'json'
  )

$("#item-images").on "hide", ->
  $('#item-info').remove()
  $('#item-images ul').remove()

$("#item-images ul a").click (event)->
  event.preventDefault()
  $.post(
    '/items',
    {item: {
      num_iid: $('#item-info').data('id'),
      nick: $('#item-info').data('nick'),
      title: $('#item-info').data('title'),
      price: $('#item-info').data('price'),
      commission: $('#item-info').data('commission'),
      volume: $('#item-info').data('volume'),
      click_url: $('#item-info').data('click_url'),
      pic_url: $('img', this).attr('src')
    }},
    ->
      $("#item-images").modal('hide')
    "json"
  )

