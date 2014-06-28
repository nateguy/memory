# @board = [0..15].map (x) -> 0
board = []
used = []
lastmove = -1

$ ->

  #for i in [0..(board.length - 1)]
  #  board[i] = 0

  #  $(".n#{i}").html('Click')
  dimensions = prompt "Please enter an even number"
  dimensions = Math.pow(dimensions, 2) - 1
  for i in [0..dimensions]
    $('.board').append("<div class='cell' id=#{i}><p>a</p></div>")
    board.push(0)
  length = 100 * Math.sqrt(board.length)
  $('.board').css("width","#{length}px")
  $('.board').css("height","#{length}px")
  fillCards()
  writeBoard()


  show = (arrayID) ->
     $("##{arrayID}").html("<img src=images/#{board[arrayID]}.jpg>")

  hide = (id1, id2) ->
    delay 500, ()->
      $("##{id1}").html('')
      $("##{id2}").html('')

  window.delay = (ms, fn)-> setTimeout(fn, ms)

  checkmatch = (id) ->
    if board[id] == board[lastmove]
      return true

    return false

  $('.cell').click(
   ->
    i = parseInt( $(this).attr('id') )
    console.log " " + i + " " + board[i]
    if $("##{i}").html() == ""
      show (i)

      if (checkmatch(i) == false) and (lastmove > -1)
        console.log "checkmatch: " + i + " " + lastmove
        hide(i, lastmove)
        lastmove = -1
      else if (checkmatch(i) == false) and (lastmove == -1)
        console.log "checkmatch: " + i + " " + lastmove
        lastmove = i
      else
        console.log "checkmatch: " + i + " " + lastmove
        lastmove = -1
        # $(this).html( board[i] )
    )



writeBoard = ->
  for i in [0..(board.length - 1)]
    $("##{i}").html("")

randomIndex = (x) ->
  i = Math.floor(Math.random() * x)
  if existInBoard(i, used) == false
    used.push(i)
    return i
  else
    randomIndex(x)

shuffle = (a) ->
  # From the end of the list to the beginning, pick element `i`.
  for i in [a.length-1..1]
    # Choose random element `j` to the front of `i` to swap with.
    j = Math.floor Math.random() * (i + 1)
    # Swap `j` with `i`, using destructured assignment
    [a[i], a[j]] = [a[j], a[i]]
  # Return the shuffled array.
  a

fillCards = ->
  newArray = [

  ]
  console.log "fill"

  for n in [0..((board.length/2)-1)] # generate random ID numbers
      itemID = randomIndex(8)
      newArray.push(itemID)
      newArray.push(itemID)
  newArray = shuffle(newArray)
  console.log newArray
  for n in [0..(newArray.length - 1)]
    board[n] = newArray[n]


existInBoard = (item, newArray) ->

  for n in [0..(newArray.length - 1)]
    if newArray[n] == item
      return true
  false
