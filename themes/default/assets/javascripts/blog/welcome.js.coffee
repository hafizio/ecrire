$(document).on 'scroll', ->
  $this = $(this)
  if $this.scrollTop() > 0
    $("#blogHeader").addClass('scrolled')
  else
    $("#blogHeader").removeClass('scrolled')

