request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->

	robot.respond /look up (.+)/i, (res) ->
		exploded = res.match[1].split(' ')
		manga = exploded.join('-')
		url = "http://www.anime-planet.com/anime/" + manga
		res.send 'Searching. Just a moment please ...'
		request url, (error, response, body) ->
			if not error
				$ = cheerio.load body
				summary = $("[itemprop='description']").text()
				res.send summary
			else
				res.send error