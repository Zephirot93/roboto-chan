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
				summary = $("[itemprop='description']").text().trim()
				if summary.length != 0
					# Get categories
					tags = []
					$('.categories li').each (i, el) ->
						genre = $(this).text()
						tags.push(genre)

					# Get reccomendations
					recommendations = []
					$('.recommendations li').each (i, el) ->
						title = $(this).find('h4').text().trim()
						recommendations.push(title)

					# Send message
					res.send '>'+summary
					res.send '*Tags:* '+tags.join(', ')
					res.send '*You might also like:* '+recommendations.join(', ')
					res.send url
				else
					res.send 'I\'m sorry but I couldn\'t find anything ... ｡･ﾟﾟ*(>д<)*ﾟﾟ･｡' 
			else
				res.send error