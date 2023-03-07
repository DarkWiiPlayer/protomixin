protomixin = require 'protomixin'

describe 'protomixin', ->
	before_each ->
		export mixin = protomixin\new { method: => true }
	describe 'constructor', ->
		it 'creates a new table', ->
			assert.is.table protomixin.new()
		it 'keeps existing objects', ->
			tab = {}
			assert.same tab, protomixin.new(mixin, tab)
		it 'preserves metatables', ->
			tab = setmetatable({}, {value: true})
			protomixin.new(mixin, tab)
			assert.is.function getmetatable(tab).__index
			assert.is.true getmetatable(tab).value
	it 'inherits functions', ->
		new = mixin\new!
		assert.is.function new.method
		assert.true new\method!
	it 'overwrites functions', ->
		parent = mixin\new { method: => false }
		child = parent\new!
		assert.false child\method!
	it 'uses latest mixed-in method', ->
		first = mixin { value: 1 }
		second = mixin { value: 2 }
		child = {}
		first(child)
		second(child)
		assert.same 2, child.value
