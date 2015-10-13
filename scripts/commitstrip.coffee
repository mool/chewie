# Description:
#   None
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot commitstrip - Returns a random commitstrip image
#
# Author:
#   Nestroll
#
# Source:
#   http://www.commitstrip.com/?random=1

Select      = require('soupselect').select
HTMLParser  = require 'htmlparser'

module.exports = (robot)->
  robot.respond /commitstrip/i, (message)->
    send_meme message, false, (url, title)->
      message.send url, title

send_meme = (message, location, response_handler)->
  meme_domain = 'http://www.commitstrip.com/en'
  location  ||= '/?random=1'
  if location.substr(0, 4) != 'http'
    url = meme_domain + location
  else
    url = location

  message.http( url ).get() (error, response, body)->
    return response_handler 'Sorry, something went wrong' if error

    if response.statusCode in [302, 307]
      location = response.headers['location']
      return send_meme( message, location, response_handler )

    img_src = get_comic( body, '.post img')
    img_title = get_title( body, '.post .entry-title' )

    if img_src.substr(0, 4) != 'http'
      img_src = "http:#{img_src}"

    response_handler img_src, img_title

select_element = (body, selector)->
  html_handler  = new HTMLParser.DefaultHandler((()->), ignoreWhitespace: true )
  html_parser   = new HTMLParser.Parser html_handler

  html_parser.parseComplete body
  Select( html_handler.dom, selector)[0]

get_comic = (body, selector)->
  select_element(body, selector).attribs.src

get_title = (body, selector)->
  select_element(body, selector).children[0].raw
