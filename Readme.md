## Intro
This script will download your Google Web History. The backlog of all your searches
It only works for around 4k of entries. It would be more work in order to support downloading
the full web history. There's information on how to do it here:


http://geeklad.com/updated-script-to-download-google-history

I'm posting this code mostly so that others can fork and fix it.

## Usage:
Just run it from the commandline and give it your Google account and your password:


ruby ./downloader.rb donaldduck@gmail.com daisy69


This script needs the Mechanize Ruby library. Just install it via gem


gem install mechanize

