
import sys
import pycurl
import json
from StringIO import StringIO

proxy = {"host": "web-proxy.oa.com", "port": 8080}
key = "180CEA44747238EB38EDED2AB40D6AD3"
url = "http://dict-co.iciba.com/api/dictionary.php?type=json&key=%s&w=%s"
ua = "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36"

def List2Str(slist, sep = " "):
    ss = ""
    for s in slist:
        if len(ss) <= 0:
            ss = s
        else:
            ss = "%s%s%s" % (ss, s, sep)
        
    return ss

def Query(word):
    #print "Query '%s' in python" % word
    
    buffer = StringIO()
    surl = url % (key, word)

    c = pycurl.Curl()

    c.setopt(c.URL, surl)
    c.setopt(c.WRITEDATA, buffer)
    #c.setopt(pycurl.PROXY, proxy['host'])
    #c.setopt(pycurl.PROXYPORT, proxy['port'])

    c.perform()
    c.close()

    body = buffer.getvalue()
    info = json.loads(body)

    if not bool(info.get("word_name")):
        print("\nNot found '%s'\n" % word)
        return 

    print("")
    print(info["word_name"])

    for symbol in info["symbols"]:

        print("")
        if bool(symbol.get("ph_en")):
            print("EN: [%s]" % symbol["ph_en"].encode("utf-8"))
        if bool(symbol.get("ph_am")):
            print("AM: [%s]" % symbol["ph_am"].encode("utf-8"))

        if not bool(symbol.get("parts")):
            continue

        print("")
        for part in symbol["parts"]:
            if bool(part.get("part") and bool(part.get("means"))):
                ss = List2Str(part["means"])
                print("%s: " % part["part"]),
                print(ss.encode("utf-8"))

        print("")

Query(sys.argv[1])
