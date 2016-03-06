request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
	robot.respond /look up manga (.*)/i, (res) ->
		get_summary res.match[1]

get_summary = (manga_name) ->
	manga = format_manga_name manga_name
	url = "http://www.anime-planet.com/anime/" + manga
	request url, (error, response, body) ->
		if not error
			$ = cheerio.load body
			summary = $("[itemprop='description']").text()
			res.send summary
		else
			res.send error

format_manga_name = (name) ->
	exploded = name.split(' ')
	exploded.join('-')