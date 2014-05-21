from bs4 import BeautifulSoup
import urllib2
import csv
import json
import collections

class PopulationTableGrabber(object):
    def __init__(self, url):
        self.page = urllib2.urlopen(url)
        self.soup = BeautifulSoup(self.page)

    def find_all_tabs(self):
        def table_has_enough_rows(elm):
            """ actually table of interest has a border,
                AND enough rows."""
            return elm.name == 'table' and \
              elm.has_attr('bordercolor') and \
              len(elm.find_all('tr')) > 20
        return self.soup.find_all(table_has_enough_rows)

    def parse_one_table(self, tab):
        ''' munge the table rows
        '''
        yearElement = tab.find(colspan='3')
        year = int(yearElement.get_text())
        rows = tab.find_all('tr')
        out = []

        # ipdb.set_trace()

        for row in rows:
            if row.find('th'):
                continue
            if row.find('td').has_attr('colspan'):
                continue
            tds = row.find_all('td')
            rowdata = {
                'year': year,
                'rank': tds[0].get_text(), 
                'city': tds[1].get_text(), 
                'pop': float(tds[2].get_text())
            }
            out.append(rowdata)
        return out

    def reshape_city_data(self, all_tabs):
        ''' list of lists of dicts'''
        return [self.parse_one_table(tab) for tab in all_tabs]

    def read_tot_pop(self, url="https://docs.google.com/spreadsheet/pub?key=0AruyJI76uB8RdFBySUhzRldyalJGTXZtY1NxT0E2Z1E&output=csv"):
        page = urllib2.urlopen(url)
        totpop = []
        for p in page[1:]:
            d = collections.OrderedDict()
            d['year'] = p[0]


        return totpop

    def write_csv(self, dicts, filename="citypop_ae.csv"):
        ''' could do without ceremony, but this preserves key order
        '''
        # print dicts
        keys = ['year', 'rank', 'city', 'pop']
        f = open(filename, 'wb')
        dict_writer = csv.DictWriter(f, keys)
        dict_writer.writer.writerow(keys)
        for this_dict in dicts:
            dict_writer.writerows(this_dict)
        f.close()

    def write_json(self, dicts, filename="citypop_ae.json"):
        totpop = self.read_tot_pop()

        # f = open(filename, 'wb')
        # print dicts[0][0].get('city')
        for outer_list in dicts:
            for inner_list in outer_list:
                print inner_list
        print json.dumps(totpop[0], indent=4)

        # print json.dumps(dicts, sort_keys=True, indent=4, separators=(',', ': '))
        # f.close()

        

pop = PopulationTableGrabber('http://www.peakbagger.com/pbgeog/histmetropop.aspx')
# pop.write_csv(pop.reshape_city_data(pop.find_all_tabs()))
pop.write_json(pop.reshape_city_data(pop.find_all_tabs()))

## I transcribed total population in millions:
## https://docs.google.com/spreadsheet/pub?key=0AruyJI76uB8RdFBySUhzRldyalJGTXZtY1NxT0E2Z1E&output=csv
## source: http://www.census.gov/population/censusdata/table-4.pdf
## and census factfinder2 tables for 2000, 2010.

## Change this file.
