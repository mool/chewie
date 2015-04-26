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
#   hubot cyanide & happiness - Returns a random C&H image
#
# Author:
#   Néstor Coppi

Select      = require( 'soupselect' ).select
HTMLParser  = require 'htmlparser'

module.exports = (robot)->
  robot.respond /(c&h|cyanide (&|and) happiness)( me)?/i, (message)->
    send_meme message, false, (url, title)->
      message.send url

send_meme = (message, location, response_handler)->
  meme_domain = 'http://explosm.net'
  location  ||= '/comics/random/'
  if location.substr(0, 4) != 'http'
    url = meme_domain + location
  else
    url = location

  message.http( url ).get() (error, response, body)->
    return response_handler 'Sorry, something went wrong' if error

    if response.statusCode == 302
      location = response.headers['location']
      return send_meme( message, location, response_handler )

    img_src = get_comic( body, 'img[src^="http://www.explosm.net/db/files/Comics"]')

    if img_src.substr(0, 4) != 'http'
      img_src = "http:#{img_src}"

    response_handler img_src

select_element = (body, selector)->
  html_handler  = new HTMLParser.DefaultHandler((()->), ignoreWhitespace: true )
  html_parser   = new HTMLParser.Parser html_handler

  html_parser.parseComplete body
  Select( html_handler.dom, selector)[0]

get_comic = (body, selector)->
  select_element(body, selector).attribs.src
