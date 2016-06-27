require 'google_drive'
require 'json'
require 'sinatra'
require "reactive-ruby"
require 'jsx'
require 'tilt'
require 'jsx'
require 'jsx/tilt'


session = GoogleDrive.saved_session("config.json")
# get important information such as user password and username etc.
ws = session.spreadsheet_by_key("1FnllGoYuUjhdF1xF1kQRIrWrv_znxqokSq84-uNw8wY").worksheets[1]
# connects to the specific spreadsheet and page 2 of it


info_holder = []
#empty array to hold the json values
i = 0
holder = Hash.new
#hash to hold the information temporarily
for number in 2..128 do
    for letter in 1..19 do
        if (ws[number, letter] != "") then # if not empty
            holder[ws[1, letter]] =  ws[number, letter] #hash is filled in with important info
  
        end
    end
    pjson = holder.to_json # hash converted to json and stored in pjson
   info_holder[i] = pjson
   i = i + 1;
   holder.clear
end


get '/jsondata' do
    info_holder
end

get '/' do
    #slim :index
     File.read(File.join('views', 'index.html'))
end


