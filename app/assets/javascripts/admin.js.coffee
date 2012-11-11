$ ->
  $('.search a').click (event)->
    event.preventDefault()
    _this = $(this)
    $.get(
      '/admin/images',
      {item_id: $(this).data('id')},
      (data)->
        $('#item-images').modal()
        $('#item-images').append("<div id='item-info' style='display: none' />")
        console.log(data.cid)
        $('#item-info').attr('data-id'         , _this.data('id'))
        $('#item-info').attr('data-cid'        , data.cid)
        $('#item-info').attr('data-price'      , _this.data('price'))
        $('#item-info').attr('data-commission' , _this.data('commission'))
        $('#item-info').attr('data-volume'     , _this.data('volume'))
        $('#item-info').attr('data-nick'       , _this.data('nick'))
        $('#item-info').attr('data-title'      , _this.data('title'))
        $('#item-info').attr('data-click_url'  , _this.data('click_url'))
        $('#item-images').append("<ul />")
        $.each(data.images, (k,v) ->
          $('ul', '#item-images').append("<li><a href='#'><img src='#{v['url']}' /></a></li>")
        )
      'json'
    )

  $("#item-images").on "hide", ->
    $('#item-info').remove()
    $('#item-images ul').remove()

  $("#item-images").on "click", "a", (event)->
    event.preventDefault()
    $.post(
      '/items',
      {item: {
        num_iid: $('#item-info').data('id'),
        category_id: $('#item-info').data('cid'),
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
    )

