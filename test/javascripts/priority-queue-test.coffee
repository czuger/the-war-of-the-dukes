assert = require('assert')
assert = require('assert')

require './test_helper'

{ PriorityQueue } = require( "../../app/assets/javascripts/local_libs/misc/priority_queue" )

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
