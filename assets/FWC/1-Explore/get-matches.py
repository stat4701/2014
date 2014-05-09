from bs4 import BeautifulSoup
import urllib2
from re import sub
import operator
import csv
import json
from unidecode import unidecode

class ScoresTableGrabber(object):
    def __init__(self, url):
        self.page = urllib2.urlopen(url)
        self.soup = BeautifulSoup(self.page)

#     def find_all_tabs(self):
#         def table_has_enough_rows(elm):
#             print '-------------------------------'
#             print elm.name
#             print elm
#             ''' actually table of interest has a border,
#                 AND enough rows.'''
#             return elm.name == 'table' and \
#               elm.has_attr('bordercolor') and \
#               len(elm.find_all('tr')) > 20
#         print 'hello'
#         return self.soup.find_all(table_has_enough_rows)
# 
#     def parse_one_table(self, tab):
#         ''' somewhat dirty, but grabs the year, skips a row, and parses the rest
#             would break if there were and asterisk row for example
#         '''
#         yearElement = tab.find(colspan='3')
#         year = int(yearElement.get_text())
#         rows = yearElement.find_parent().find_next_sibling().find_next_siblings()
#         out = []
#         for row in rows:
#             tds = row.find_all('td')
#             rowdata = {
#                 'year': year,
#                 'rank': self.fix_ordinals(tds[0].get_text()), 
#                 'city': tds[1].get_text(), 
#                 'pop': float(tds[2].get_text())
#             }
#             out.append(rowdata)
#         return out
# 
#     def reshape_city_data(self, all_tabs):
#         ''' list += rows, for all the tables'''
#         return reduce(operator.add, 
#                       [self.parse_one_table(tab) for tab in all_tabs]
#         )
# 
# 
#     def fix_ordinals(self, string):
#         ''' oh look, "1."
#         '''
#         return int(sub('[.]', '', string))


    def write_csv(self, dicts, filename="fifascores.csv"):
        ''' could do without ceremony, but this preserves key order
        '''
        keys = ['date', 'location', 'team1', 'team2', 'score', 'score1', 'score2', 'link', 'page', 'tournament']
        f = open(filename, 'wb')
        dict_writer = csv.DictWriter(f, keys)
        dict_writer.writer.writerow(keys)
        dict_writer.writerows(dicts)
        f.close()

       
    def write_json(self, dicts, filename="fifascores.json"):
#        print json.dumps(dicts, indent=4)
        
        f = open(filename, 'wb')
        f.write (json.dumps(dicts, indent=4))
        f.close()
        

#tournaments = [17, 520, 502, 504, 506, 101, 512, 104, 102, 106, 500, 534, 538, 542, 507]
#17 - Fifa World Cup
#520 - Fifa World Cup Qualifiers
#502 - Continental Final
#504 - Continental Qualifiers
#506 - Friendly
#101 - Fifa Confederations Cup
#512 - Olympic Football Tournament
#104 - Fifa U-20 World Cup
#102 - Fifa U-17 World Cup
#106 - Fifa Futsal World Cup
#500 - Fifa Beach Soccer World Cup
#534 - Friendly Futsal
#538 - Continental Qualifier Futsal
#542 - Continental Final Futsal
#507 - Fifa Futsal World Cup Qualifier

tournaments = {
17: 'Fifa World Cup',
520: 'Fifa World Cup Qualifiers',
502: 'Continental Final',
504: 'Continental Qualifiers',
506: 'Friendly',
101: 'Fifa Confederations Cup',
512: 'Olympic Football Tournament',
104: 'Fifa U-20 World Cup',
102: 'Fifa U-17 World Cup',
106: 'Fifa Futsal World Cup',
500: 'Fifa Beach Soccer World Cup',
534: 'Friendly Futsal',
538: 'Continental Qualifier Futsal',
542: 'Continental Final Futsal',
507: 'Fifa Futsal World Cup Qualifier'
}




for t in tournaments:
    print tournaments[t]

    listEnd = False
    page = 0
    games = []  
    file = 1

    while True:
        
#        t = 17
#        page = 4
        print page
        url = 'http://www.fifa.com/associations/library/_results.htmx?gender=m&idAssociation1=0&idAssociation2=0&MatchStatus=2&rangeDate=3&fromMonth=1&fromYear=1872&toMonth=1&toYear=2015&ClassificationGroup='+ str(t) + '&r=nr&page='+ str(page)
        fifa =  ScoresTableGrabber(url)
    
        for divs in fifa.soup.findAll("div"):
            if divs.get_text() == 'No data available for specified filters':
                listEnd = True
    
        if listEnd:
            break
        
    #    if page == 6:
    #        break
            
        for row in fifa.soup.findAll("tr"):
            cols = row.findAll("td")
    
            score = cols[3].get_text().strip()
            score1 = 0
            score2 = 0
            if ':' in score:
                pos1 = score.index(':')
                score1 = score[:pos1].strip()
    
                pos2 = len(score)
                if ' ' in score:
                    pos2 = score.index(' ')
                
                score2 = score[pos1+1:pos2].strip()
            
            gamelink = ''
            for link in cols[3].findAll('a'):
                gamelink = link.get('href')
            
            gamedata = {
                'date': cols[0].get_text().strip(),
                'location': unidecode(cols[1].get_text().strip()),
                'team1': unidecode(cols[2].get_text().strip()),
                'team2': unidecode(cols[4].get_text().strip()),
                'score': cols[3].get_text().strip(),
                'score1': score1,
                'score2': score2,
                'link': gamelink,
                'page': page,
                'tournament': tournaments[t]
            }
            games.append(gamedata)
            
        if (page != 0) and (page % 10 == 0):
            #write file after every 10 pages
            print tournaments[t] + str(file) + '.json'
            fifa.write_json(games, tournaments[t] + str(file) + '.json')
            fifa.write_csv(games, tournaments[t] + str(file) + '.csv')
            file = file + 1
            
        page = page + 1

    fifa.write_json(games, tournaments[t] + str(file) + '.json')
    fifa.write_csv(games, tournaments[t] + str(file) + '.csv')

    print tournaments[t] + str(file) + '.json'  

#print fifa.find_all_tabs()
#print fifa.soup.find_all(True)
#print games

#pop.write_csv(pop.reshape_city_data(pop.find_all_tabs()))
#pop.write_json(pop.reshape_city_data(pop.find_all_tabs()))


## I transcribed total population in millions:
## https://docs.google.com/spreadsheet/pub?key=0AruyJI76uB8RdFBySUhzRldyalJGTXZtY1NxT0E2Z1E&output=csv
## source: http://www.census.gov/population/censusdata/table-4.pdf
## and census factfinder2 tables for 2000, 2010.
