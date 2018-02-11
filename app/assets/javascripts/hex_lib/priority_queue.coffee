# Original code : https://jsfiddle.net/GRIFFnDOOR/r7tvg/

class Node
  constructor: (data, priority) ->
    @data = data
    @priority = priority

class @PriorityQueue

  constructor: () ->
    @heap = []

  empty: ->
    @heap.length <= 0

  push: (data, priority) ->
    console.log( 'push.data = ', data )
    node = new Node(data, priority)
    console.log( 'push.node = ', node )
    @heap.push(node)
    console.log( 'heap = ', @heap )
    @sink()
    console.log( 'heap = ', @heap )

  pop: ->
#    console.log( @heap )
    console.log( 'pop.heap = ', @heap )
    topVal = @heap.pop()
    console.log( 'pop.heap = ', @heap )
    console.log( 'topVal = ', topVal )
    topVal.data

  sink: ->
    i = @heap.length - 2
    while i >= 0
      if @heap[i].priority > @heap[i+1].priority
        @swap( i, i+1 )
      else
        break

  swap: (i, j) ->
    temp = @heap[i]
    @heap[i] = @heap[j]
    @heap[j] = temp