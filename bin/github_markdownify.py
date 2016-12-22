
import subprocess
import json

tmpfile = open('/Users/Scott/.mail_markdown.txt', 'r')
tmptext = tmpfile.read().decode('utf-8')

curlData = {
        "text": tmptext,
        "mode": 'gfm'
        }
curlDataString = json.dumps(curlData).decode('utf-8')

url = 'https://api.github.com/markdown'

curl_args = [
             'curl',
             '-H',
             'Content-Type: application/json',
             '-d',
             curlDataString,
             url
             ]

print(subprocess.Popen(curl_args, stdout=subprocess.PIPE).communicate()[0].decode('utf-8'))



