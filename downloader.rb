require 'rubygems'
require 'mechanize'
require 'pp'

# This script only works for around 4k of entries. It would be more work in order to support downloading
# the full web history. There's information on how to do it here:
# http://geeklad.com/updated-script-to-download-google-history


##################################################
# Urls
##################################################

webhistory_url = "https://www.google.com/history/lookup?q=&output=rss&num=%i&start=%i"
login_url = "https://accounts.google.com/ServiceLogin"


##################################################
# Script
##################################################

a = Mechanize.new
a.get(login_url) do |page|

  ########################################
  # the login into google 
  my_page = page.form_with(:action => 'https://accounts.google.com/ServiceLoginAuth') do |f|
    f.Email  = ARGV[0]
    f.Passwd = ARGV[1]
  end.click_button

  ########################################
  # and now download all the web history
  # we just move on, until we have none left
  startcounter = 0
  packagelen = 1000
  document = 1

  while true
    url = webhistory_url % [packagelen, startcounter]
    p url
    a.get(url) do |resultPage|
      # and write out the html
      html = resultPage.body
      # and write out the code to a file
      htmlfile = "web_history%i.html" % document
      File.open(htmlfile, 'w'){|f| f.write(html)}
      break if not html =~ /pubDate/
    end
    startcounter+=packagelen
    document+=1
  end
end
