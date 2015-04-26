# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   tell a nestroll quote
#
# Author:
#  mool

nestroll_quotes = [
  "de samer is mayic",
  "mmmm, flojito flojito",
  "wo wo wo...",
  "HOY HAY VAQUITA!",
  "http://cdn.memegenerator.net/instances/500x/50483718.jpg",
  "igual... si pintaba la fresca, le chuleaba el perro!",
  "cachai la wea?",
  "Estupido y sensual Cuco...",
  "Hay que rectificar el mate"
]

module.exports = (robot) ->
  robot.hear /nestroll/i, (msg) ->
    msg.send random_msg()

random_msg = () ->
  rand = parseInt(Math.random() * 300) % nestroll_quotes.length
  nestroll_quotes[rand]
