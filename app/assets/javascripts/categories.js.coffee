$ ->
  $("#create_category").click (event)->
    event.preventDefault()
    data = new Array()
    $("input:checked").each (index)->
      data[index] = {id: $(this).attr("value"), name: $(this).next().text()}

    data = JSON.stringify(data)
    $("#data").attr("value", data)
    $("#category-form").submit()
