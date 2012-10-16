jQuery ->
  $('.slide-panel').hover(
    ->
      $(this).css('right', '0')
    ->
      $(this).css('right', '-80px')
  )

  $('.qq-service').hover(
    ->
      $(this).css('right', '0')
      $(this).css('bottom', '0')
    ->
      $(this).css('right', '-5px')
      $(this).css('bottom', '-35px')
  )

  $('.go_top').click ->
    $('body').animate { scrollTop: 0 }, 800

  $(window).scroll ->
    if $(this).scrollTop() > 0
      $('.go_top').fadeIn()
    else
      $('.go_top').fadeOut()

  $('.bookmark').click (ev)->
    ev.preventDefault()
    e = $(this).href || document.location.href
    t = $(this).title || document.title

    if window.sidebar # mozilla
      window.sidebar.addPanel(t, e, "")
    else if window.opera && window.print # opera
      $(this).attr("href", e)
      $(this).attr("title", t)
      $(this).attr("rel", "sidebar")
      $(this).click()
    else if document.all # ie
      window.external.AddFavorite(e, t)
    else
      alert("请点击右键或者按<Ctrl-D>把本地址放入收藏夹中，如有疑问请联系客服！")

