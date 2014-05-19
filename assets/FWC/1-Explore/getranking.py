from bs4 import BeautifulSoup
import urllib2
from re import sub
import operator
import csv
import json
from unidecode import unidecode

class RankingTableGrabber(object):
    def __init__(self, url):
        
        pageNotReturned = True
        
        while pageNotReturned:
            try:
                self.page = urllib2.urlopen(url, timeout = 10)
                self.soup = BeautifulSoup(self.page)
                pageNotReturned = False
                
            except Exception:
                print "====Timeout. Trying again!=====" 
                pageNotReturned = True
                pass
        
    def write_csv(self, dicts, filename="fifarankings.csv"):
        ''' could do without ceremony, but this preserves key order
        '''
        keys = ['confederation', 'date', 'rank', 'conrank', 'country', 'point', 'delta']
        f = open(filename, 'wb')
        dict_writer = csv.DictWriter(f, keys)
        dict_writer.writer.writerow(keys)
        dict_writer.writerows(dicts)
        f.close()

       
    def write_json(self, dicts, filename="fifarankings.json"):
        
        f = open(filename, 'wb')
        f.write (json.dumps(dicts, indent=4))
        f.close()
        
confederation = {
23913: 'CAF',
23914: 'CONCACAF',
23915: 'CONMEBOL',
23916: 'OFC',
25998: 'AFC',
27275: 'UEFA',
}

for c in confederation:
    
    listEnd = False
    page = 10
    countryrank = []  
    file = 1
    rank = 2

    while True:
        
        print confederation[c] + ' - ' + str(rank) 
        url = 'http://www.fifa.com/worldranking/rankingtable/gender=m/rank=' + str(rank) + '/confederation=' + str(c) + '/page=' + str(page) + '/_ranking_table.html'
        fifa = RankingTableGrabber(url)
    
        for divs in fifa.soup.findAll("div"):
            if 'Last Updated' in divs.get_text() and len(divs.get_text())<30:
                date = divs.get_text()[14:]
                if date.strip() == '':
                    listEnd = True
                    print 'end of file'
                print date
                
        if listEnd:
        #or rank == 20:
            break
        rowsRead = 0
        
        for row in fifa.soup.findAll("tr"):
            rowsRead = rowsRead + 1
            
            if rowsRead != 1:
                cols = row.findAll("td")
                #print len(cols)
                if len(cols) <> 8 or cols[1].get_text().strip()=='-':
                    break
                else:
                    rankdata = {
                        'confederation' : confederation[c],
                        'date': date,
                        'rank': unidecode(cols[1].get_text().strip()),
                        'conrank': unidecode(cols[2].get_text().strip()),
                        'country': unidecode(cols[3].get_text().strip()),
                        'point': unidecode(cols[4].get_text().strip()),
                        'delta': unidecode(cols[5].get_text().strip()),
                    }
                    countryrank.append(rankdata)
            
        
        rank = rank + 1

    print confederation[c] + '.json'
    fifa.write_json(countryrank, confederation[c] + '.json')
    fifa.write_csv(countryrank, confederation[c] + '.csv')