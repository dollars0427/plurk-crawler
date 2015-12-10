# encoding: UTF-8

require 'rubygems'
require 'tjplurker'
require 'tzinfo'

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

timeZone =

startTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 0, 0, 0, 0)
startTimeMs = startTime.strftime('%Q')
endTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 23, 59, 59, 59)
endTimeMs = endTime.strftime('%Q')

#Start to get plurk which posted on today

tjp = TJPlurker.new(consumerKey, consumerSecert, accessKey, accessSecret)

userId = get_uid("Altia").to_i

publicPlurks = tjp.api('/APP/Timeline/getPublicPlurks', user_id: userId, limit:50)['plurks']

publicPlurks.each do |publicPlurk|

	postedDate = DateTime.httpdate(publicPlurk['posted']).utc_to_local.strftime('%Y%m%d%H%M%S')
	postedDateMs = DateTime.httpdate(publicPlurk['posted']).strftime('%Q')

	#If the plurk is posted on today, write the content and reponse to html flie

	if postedDateMs > startTimeMs and postedDateMs < endTimeMs

		fileHtml = File.new("./output/#{postedDate}.html", 'w')
		fileHtml.puts '<html><body><head><meta charset="UTF-8"></head>'

		username = getUserName(tjp, publicPlurk['owner_id'])

		content = publicPlurk['content']

		postedDate = DateTime.httpdate(publicPlurk['posted']).strftime('%Y-%m-%d %H:%M')

		fileHtml.puts '發噗日期：' + postedDate  + '<br>'
		fileHtml.puts '發噗者：' + username  + '<br><br>'

		fileHtml.puts content
		fileHtml.puts '<br><hr>'

		publicPlurkId = publicPlurk['plurk_id']

		responses = tjp.api('/APP/Responses/get', plurk_id: publicPlurkId)['responses']

		responses.each do |response|

			responser = getUserName(tjp, response['user_id'])
			responseContent = response['content']

			fileHtml.puts responser + ':' + '<br>'
			fileHtml.puts responseContent
			fileHtml.puts '<br><hr>'
		end

		fileHtml.puts '</body></html>'
		fileHtml.close
	end
end
