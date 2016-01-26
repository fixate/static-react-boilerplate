watching = false

module.exports = (err) ->
  console.log err.toString()
  if watching then @emit('end') else process.exit(1)



