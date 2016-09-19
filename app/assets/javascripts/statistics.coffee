# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#Initialize the datePicker(I have taken format as mm - dd - yyyy, you can have your own)

DATE_FORMAT = 'DD-MM-YYYY'
loadWeeklyData = (date) ->
  $('td.day.active').parent().css('background-color', '#337ab7')
  firstDate = moment(date, DATE_FORMAT).day(0).format(DATE_FORMAT)
  lastDate = moment(date, DATE_FORMAT).day(6).format(DATE_FORMAT)
  localStorage.setItem("lastDate", moment(date, DATE_FORMAT).format(DATE_FORMAT));
  $("#initial_date").val(firstDate)
  $("#end_date").val(lastDate)

  $.ajax(url: "/statistics/data_range_date?initial_date=#{firstDate}&end_date=#{lastDate}")
  .done (data) ->
    $('#products-sells tbody tr').remove()
    $('#items-sells tbody tr').remove()
    $('#orders-customers tbody tr').remove()

    $(data.products).each (index, prod) ->
      $('#products-sells tbody').append($("<tr><th>#{prod.name}</th><th>#{prod.count}</th></tr>"))
    $(data.items).each (index, item) ->
      $('#items-sells tbody').append($("<tr><th>#{item.name}</th><th>#{item.count}</th></tr>"))
    $(data.orders_customers.orders_customers).each (index, it) ->
      $('#orders-customers tbody').append($(
        "<tr><th>#{it.number_of_orders}</th>< +
         <<th>#{it.number_of_customers}</th>< +
          <<th>#{Math.round((it.number_of_orders / data.orders_customers.total_count) * 100)}%</th></tr>"))


ready = ->
  $("#weeklyDatePicker").datetimepicker({
    format: DATE_FORMAT,
    calendarWeeks: true,
    inline: true,
    defaultDate: moment(localStorage.getItem("lastDate"), DATE_FORMAT)
  }).on('dp.change', (e) ->
    loadWeeklyData(e.date)
  )

  $("#monthlyDatePicker").datetimepicker({
      format: 'MM/YYYY',
      inline: true,
  }).on('dp.change', (e) ->
#    loadWeeklyData(e.date)
  )

  loadWeeklyData(moment(localStorage.getItem("lastDate"), DATE_FORMAT))
  $('td.day.active').parent().css('background-color', '#337ab7')

$(document).ready(ready)
$(document).on('turbolinks:load', ready)
