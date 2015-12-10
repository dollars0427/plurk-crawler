# encoding: UTF-8

require 'rubygems'
require 'tjplurker'

include TJP

#Get plurk username by user id.

def getUserName(tjp, userId)

	result = tjp.get_public_profile(userId)

	username =  result['user_info']['display_name']

	return username

end

#Get the consumer key and access key from setting file

settingFile = File.read('./setting.json')
setting = JSON.parse(settingFile)

consumerKey = setting['consumerKey']
consumerSecert = setting['consumerSecert']
accessKey = setting['accessKey']
accessSecret = setting['accessSecret']

#Get the start time and end time of today

startTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 0, 0, 0, 0)
startTimeMs = startTime.strftime('%Q')
endTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 23, 59, 59, 59)
endTimeMs = endTime.strftime('%Q')

#Start to get plurk which posted on today

tjp = TJPlurker.new(consumerKey, consumerSecert, accessKey, accessSecret)

publicPlurks = tjp.api('/APP/Timeline/getPublicPlurks', user_id: userId)['plurks']

publicPlurks.each do |publicPlurk|

	postedDate = DateTime.httpdate(publicPlurk['posted']).strftime('%Y%m%d%H%M%S')
	postedDateMs = DateTime.httpdate(publicPlurk['posted']).strftime('%Q')

	#If the plurk is posted on today, write the content and reponse to html flie

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
