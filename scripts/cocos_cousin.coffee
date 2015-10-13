# Description:
#   Show a random photo of Coco's cousin when hubot hears iihh
#
# Author:
#  Pablo Gutiérrez del Castillo <pablogutierrezdelc@gmail.com>

photos = [
  "https://pbs.twimg.com/media/BnVsPkOCAAAomZ_.jpg",
  "https://pbs.twimg.com/profile_images/620685661037830144/lqWQd6z2.jpg",
  "http://puu.sh/kInUA/c4e7b0744c.png"
]

module.exports = (robot) ->
  robot.hear /.*(iihh).*/i, (msg) ->
    msg.send msg.random photos
