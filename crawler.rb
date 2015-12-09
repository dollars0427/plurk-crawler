#encoding: UTF-8

require 'rubygems'
require "tjplurker"

include TJP

settingFile = File.read('./setting.json')
setting = JSON.parse(settingFile)

consumerKey = setting['consumerKey']
consumerSecert = setting['consumerSecert']
accessKey = setting['accessKey']
accessSecret = setting['accessSecret']

initTime = DateTime.new(DateTime.now.year, DateTime.now.month, DateTime.now.day, 0, 0, 0, 0)

initTimeMs = initTime.strftime('%Q')

tjp = TJPlurker.new(consumerKey, consumerSecert, accessKey, accessSecret)

userId = get_uid("bluewinds0624").to_i

publicPlurks = tjp.api("/APP/Timeline/getPublicPlurks",{user_id: userId})['plurks']

publicPlurks.each do |publicPlurk|

	publicPlurkId = publicPlurk['plurk_id']

	postedDate = DateTime.httpdate(publicPlurk['posted']).strftime('%Q')

	responses = tjp.api("/APP/Responses/get",{plurk_id: publicPlurkId})['responses']

end
