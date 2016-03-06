robot.respond /look up (*)/i, (res) ->
	robot.send "Ready to look up "+res.match[1]

request = require 'request'
cheerio = require 'cheerio'

robot.respond /look up manga "(*)"/i, (res) ->
	robot.send "Ready to go!"
	lookup = res.match[1]
	exploded = lookup.split(' ')
	manga = exploded.join([separator='-'])
	url = 'http://www.anime-planet.com/anime/'+manga
	`  
	request(url, function (error, response, body) {
  		if (!error) {
    		var $ = cheerio.load(body),
      		summary = $("[itemprop=description]").text();
      
    		robot.send(summary);
  		} else {
    		robot.send("We’ve encountered an error: " + error);
  		}
	});
	`