request = require 'request'
cheerio = require 'cheerio'
utf8 = require 'utf8'

module.exports = (robot) ->
	robot.respond /define (.+)/i, (res) ->
		res.send 'Just a moment please ...'
		pre_url = 'http://jisho.org/search/'+res.match[1]
		url = utf8.encode(pre_url)
		request url, (error, response, body) ->
			results = []
			$ = cheerio.load body
			result = $('.concept_light').each (i, elem) ->
				results[i] = {
					'word': $(this).find('.text').text().trim(),
					'furigana': $(this).find('.concept_light-representation .furigana').text().trim(),
					'meaning': $(this).find('.meaning-meaning').first().text().trim()
				}
			if results.length > 0	
				msg = ''
				for result in results[0..4]
					if result.word.length != 0
						msg += result.word + ' [' + result.furigana + ']' + ': ' + result.meaning + '\n'
				res.send(msg.trim())	
			else
				res.send 'I\'m sorry but I coudln\'t find anything ... ｡･ﾟﾟ*(>д<)*ﾟﾟ･｡'
