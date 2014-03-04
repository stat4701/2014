from bs4 import BeautifulSoup
import urllib2
from re import sub
import operator
import csv

class PopulationTableGrabber(object):
    def __init__(self, url):
        self.page = urllib2.urlopen(url)
        self.soup = BeautifulSoup(self.page)

    def find_all_tabs(self):
        def table_has_enough_rows(elm):
            ''' actually table of interest has a border,
                AND enough rows.'''
            return elm.name == 'table' and \
              elm.has_attr('bordercolor') and \
              len(elm.find_all('tr')) > 20
        return self.soup.find_all(table_has_enough_rows)

    def parse_one_table(self, tab):
        ''' somewhat dirty, but grabs the year, skips a row, and parses the rest
            would break if there were and asterisk row for example
        '''
        yearElement = tab.find(colspan='3')
        year = int(yearElement.get_text())
        rows = yearElement.find_parent().find_next_sibling().find_next_siblings()
        out = []
        for row in rows:
            tds = row.find_all('td')
            rowdata = {
                'year': year,
                'rank': self.fix_ordinals(tds[0].get_text()), 
                'city': tds[1].get_text(), 
                'pop': float(tds[2].get_text())
            }
            out.append(rowdata)
        return out

    def reshape_city_data(self, all_tabs):
        ''' list += rows, for all the tables'''
        return reduce(operator.add, 
                      [self.parse_one_table(tab) for tab in all_tabs]
        )


    def fix_ordinals(self, string):
        ''' oh look, "1."
        '''
        return int(sub('[.]', '', string))


    def write_csv(self, dicts, filename="citypop.csv"):
        ''' could do without ceremony, but this preserves key order
        '''
        keys = ['year', 'rank', 'city', 'pop']
        f = open(filename, 'wb')
        dict_writer = csv.DictWriter(f, keys)
        dict_writer.writer.writerow(keys)
        dict_writer.writerows(dicts)
        f.close()
        

pop = PopulationTableGrabber('http://www.peakbagger.com/pbgeog/histmetropop.aspx')
pop.write_csv(pop.reshape_city_data(pop.find_all_tabs()))

## I transcribed total population in millions:
## https://docs.google.com/spreadsheet/pub?key=0AruyJI76uB8RdFBySUhzRldyalJGTXZtY1NxT0E2Z1E&output=csv
## source: http://www.census.gov/population/censusdata/table-4.pdf
<<<<<<< HEAD
## and census factfinder2 tables for 2000, 2010.
=======
## and census factfinder2 tables for 2000, 2010.

## Change this file.
>>>>>>> 40bc82977fb051fed7b2704b416bbab6fb448933
