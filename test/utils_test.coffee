assert = require 'assert'
Path   = require 'path'
Utils  = require '../src/utils'

describe 'Utils', ->
  describe '#extend()', ->
    it 'sould return {a:1, b:2, c:3}', ->
      dest_obj = { a: 1, b: 3 }
      src_obj  = { b: 2, c: 3 }
      result   = Utils.extend(dest_obj, src_obj)
      assert.deepEqual(result, {a:1, b:2, c:3})

    it 'sould return {a:1, b:2, c: { a: 1, b: 2 }}', ->
      dest_obj = { a: 1, c: { a: 1 } }
      src_obj  = { b: 2, c: { b: 2 } }
      result   = Utils.extend(true, dest_obj, src_obj)
      assert.deepEqual(result, {a:1, b:2, c: { a: 1, b: 2 }})

    it 'sould return {a:1, b:2, c: { a: 5, b: 10 }}', ->
      dest_obj = { a: 1, c: { a: 1 } }
      src_obj  = { b: 2, c: { a: 5, b: 10 } }
      result   = Utils.extend(true, dest_obj, src_obj)
      assert.deepEqual(result, {a:1, b:2, c: { a: 5, b: 10 }})

    it 'chould return { a: [1,2,3] }', ->
      dest_obj = { a: [1] }
      src_obj  = { a: [2, 3] }
      result   = Utils.extend(true, dest_obj, src_obj)
      assert.deepEqual(result, { a: [1,2,3] })

  describe '#add()', ->
    it 'shoud return [1,2,3]', ->
      dest    = []
      result  = Utils.add dest, 1, 2, 3
      assert.deepEqual(result, [1, 2, 3])

    it 'shoud return [1,2,3,4,5,6,7]', ->
      dest    = [1,2,3]
      result  = Utils.add dest, [4,5], [6,7]
      assert.deepEqual(result, [1,2,3,4,5,6,7])

  describe '#files()', ->
    it 'shoud have length', ->
      list = Utils.files __dirname + '/../src'
      assert.equal(9, list.length)

    it 'shoud have length', ->
      root  = Path.join(__dirname, '..', 'src')
      list  = Utils.files root
      assert.equal(9, list.length)

    it 'shoud have length', ->
      root  = Path.join(__dirname, '..', 'src')
      match = Path.join(root, 'asset-pipeline.coffee')
      list  = Utils.files(root)
      assert.equal(match, list[0])
