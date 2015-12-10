# encoding: UTF-8

require 'rubygems'
require 'tjplurker'

include TJP

def getUserName(tjp, userId)

	result = tjp.get_public_profile(userId)

	username =  result['user_info']['display_name']

	return username

end

settingFile = File.read('./setting.json')
setting = JSON.parse(settingFile)

consumerKey = setting['consumerKey']
consumerSecert = setting['consumerSecert']
accessKey = setting['accessKey']
accessSecret = setting['accessSecret']

startTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 0, 0, 0, 0)

startTimeMs = startTime.strftime('%Q')

endTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 23, 59, 59, 59)

endTimeMs = endTime.strftime('%Q')

tjp = TJPlurker.new(consumerKey, consumerSecert, accessKey, accessSecret)

userId = get_uid('bluewinds0624').to_i

publicPlurks = tjp.api('/APP/Timeline/getPublicPlurks', user_id: userId)['plurks']

publicPlurks.each do |publicPlurk|

	postedDate = DateTime.httpdate(publicPlurk['posted']).strftime('%Y%m%d%H%M%S')
	postedDateMs = DateTime.httpdate(publicPlurk['posted']).strftime('%Q')

	if postedDateMs > startTimeMs and postedDateMs < endTimeMs

		fileHtml = File.new("./output/#{postedDate}.html", 'w')
		fileHtml.puts '<html><body><head><meta charset="UTF-8"></head>'

		publicPlurkId = publicPlurk['plurk_id']

		responses = tjp.api('/APP/Responses/get', plurk_id: publicPlurkId)['responses']

		responses.each do |response|
			fileHtml.puts response['content']
			fileHtml.puts '</br>'
		end

		fileHtml.puts '</body></html>'
		fileHtml.close
	end
end
