require 'rubygems'
require "tjplurker"
require "json"

include TJP

settingFile = File.read('./setting.json')
setting = JSON.parse(settingFile)

consumerKey = setting['consumerKey']
consumerSecert = setting['consumerSecert']
accessKey = setting['accessKey']
accessSecret = setting['accessSecret']
