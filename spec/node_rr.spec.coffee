describe "Sample Test", ->
  it "should pass becuase it does nothing", ->
    expect("hello").toEqual("hello")
    
  it "should pass becuase it does nothing", ->
    expect("goodbye").not.toEqual("hello")

  it "should should look cool while doing an async test", ->
    runs ->
      foo = 0
      foo++
      expect(foo).toEqual 1

  # # Working with async tests the old way
  # it "shows asynchronous test", ->
  #   setTimeout (->
  #     console.log "second"
  #     expect("second").toEqual "second"
  #     asyncSpecDone()
  #   ), 1
  #   console.log "first"
  #   expect("first").toEqual "first"
  #   asyncSpecWait()

  # # Working with async tests the new way
  # it "shows asynchronous test node-style", (done) ->
  #   setTimeout (->
  #     console.log "new second"
  #     expect("second").toEqual "second"
  #     done()
  #   ), 1
  #   console.log "new first"
  #   expect("first").toEqual "first"

