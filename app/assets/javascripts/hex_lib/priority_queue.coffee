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
    node = new Node(data, priority)
    @heap.push(node)
    @sink()

  pop: ->
#    console.log( @heap )
    topVal = @heap.pop()
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

  isHigherPriority: (i, j) ->


tq = new PriorityQueue()
tq.push("bob", 1)
tq.push("rob", 16)
tq.push("martin", 5)
console.log(tq.pop())
console.log(tq.pop())
console.log(tq.pop())