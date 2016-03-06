request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
	robot.respond /look up manga "(.*)"/i, (res) ->
		name = res.match[1]	
		exploded = name.split(' ')
		manga_name = exploded.join('-')	
		url = "http://www.anime-planet.com/anime/" + manga
		request url, (error, response, body) ->
			if not error
				$ = cheerio.load body
				summary = $("[itemprop='description']").text()
				res.send summary
			else
				res.send error