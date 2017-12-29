# Original code : https://jsfiddle.net/GRIFFnDOOR/r7tvg/

class Node
  consotructor: (data, priority) ->
    @data = data
    @priority = priority

class @PriorityQueue

  constructor: () ->
    @heap = []

  empty: ->
    @heap.length <= 0

  push: (data, priority) ->
    node = new Node(data, priority)
    @bubble @heap.push(node) - 1

  pop: ->
    console.log( @heap )
    topVal = @heap[0].data
    @heap[0] = @heap.pop()
    @sink 1
    console.log( topVal )
    topVal

  bubble: (i) ->
    while i > 1
      parentIndex = i >> 1
      # <=> floor(i/2)
      # if equal, no bubble (maintains insertion order)
      if !@isHigherPriority(i, parentIndex)
        break
      @swap i, parentIndex
      i = parentIndex

  sink: (i) ->
    while i * 2 < @heap.length
    # if equal, left bubbles (maintains insertion order)
      leftHigher = !@isHigherPriority(i * 2 + 1, i * 2)
      childIndex = if leftHigher then i * 2 else i * 2 + 1
      # if equal, sink happens (maintains insertion order)
      if @isHigherPriority(i, childIndex)
        break
      @swap i, childIndex
      i = childIndex

  swap: (i, j) ->
    temp = @heap[i]
    @heap[i] = @heap[j]
    @heap[j] = temp

  isHigherPriority: (i, j) ->
    @heap[i].priority < @heap[j].priority