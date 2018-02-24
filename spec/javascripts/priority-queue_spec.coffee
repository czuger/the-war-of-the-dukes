#assert = require('assert')

##=require 'local_libs/priority_queue.coffee'

describe 'PriorityQueue', ->

  beforeEach ->
    @pq = new PriorityQueue()

  describe '#pop()', ->

    it 'should return the right value', ->

      @pq.push("bob", 1)
      @pq.push("rob", 16)
      @pq.push("martin", 5)

      @pq.pop().should.equal 'rob'
      @pq.pop().should.equal 'martin'
      @pq.pop().should.equal 'bob'
