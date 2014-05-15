import pycountry
import json

country_list = []
country_dict = pycountry.countries
missing_dict = {'Korea': 'Korea, Republic of', 'Chinese Taipei': 'Taiwan, Province of China', "Palestinian Nat'l Auth.": 'Palestinian Territory, Occupied', 'Slovak Republic': 'Slovakia', '"Macedonia, Rep. of"': 'Macedonia, Republic of', '"Moldova, Rep. of"': 'Moldova, Republic of', 'Macao-China': 'Macao', 'Shanghai-China': 'China', '"Iran, Islamic Rep. of"': 'Iran, Islamic Republic of', 'Hong Kong SAR': 'Hong Kong'}
for c in country_dict:
    country_list.append(c.name)
countries = {}
country_abb = []
out_dict = {}

f = open('countries.csv')
for line in f:
    line = line[:-2]
    if line in country_list:
        country = pycountry.countries.get(name=line)
        countries[line] = country.alpha2
        country_abb.append(country.alpha2)
    elif line in missing_dict:
        country = pycountry.countries.get(name=missing_dict[line])
        countries[line] = country.alpha2
        country_abb.append(country.alpha2)

f.close()

for i in range(0, len(country_abb)):
    out_dict[country_abb[i]] = {}
    for test in ['Compare', 'PISA', 'TIMSS']:
        out_dict[country_abb[i]][test] = {}
        for filt in ['1-2-3', '1-2', '1-3', '2-3', 'Any']:
            out_dict[country_abb[i]][test][filt] = {}
            for rnd in ['1', '2', '3']:
                if rnd in filt or filt == 'Any':
                    out_dict[country_abb[i]][test][filt][rnd] = {}
                    for sjt in ['Math', 'Science']:
                        out_dict[country_abb[i]][test][filt][rnd][sjt] = {}
                        for stat in ['Mean', 'StDev']:
                            out_dict[country_abb[i]][test][filt][rnd][sjt][stat] = {}
                            for sex in ['Both', 'Male', 'Female']:
                                out_dict[country_abb[i]][test][filt][rnd][sjt][stat][sex] = {}
                                for cont in ['All', 'Num', 'Alg', 'Geom', 'Data']:
                                    if test == 'TIMSS' or cont == 'All':
                                        out_dict[country_abb[i]][test][filt][rnd][sjt][stat][sex][cont] = 'NA'


def addData(file_name, filt, test):
    f = open(file_name)
    count = 0
    headers = ''
    for line in f:
        line = line[:-2]
        ln = line.split(",")
        if count == 0:
            headers = ln
        else:
            country = ln[1].replace('"','')
            rnd = ln[3]
            sjt = ln[4].replace('"','')
            if country in countries:
                if test == 'PISA' or test == 'both':
                    out_dict[countries[country]]['PISA'][filt][rnd][sjt]['Mean']['Both']['All'] = ln[6]
                    out_dict[countries[country]]['PISA'][filt][rnd][sjt]['StDev']['Both']['All'] = ln[7]
                    out_dict[countries[country]]['PISA'][filt][rnd][sjt]['Mean']['Male']['All'] = ln[14]
                    out_dict[countries[country]]['PISA'][filt][rnd][sjt]['Mean']['Female']['All'] = ln[15]
                if test == 'TIMSS' or test == 'both':
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Both']['All'] = ln[44]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['StDev']['Both']['All'] = ln[45]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Male']['All'] = ln[52]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Female']['All'] = ln[53]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Both']['Num'] = ln[54]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Both']['Alg'] = ln[55]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Both']['Geom'] = ln[57]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Both']['Data'] = ln[58]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Female']['Num'] = ln[59]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Male']['Num'] = ln[60]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Female']['Alg'] = ln[61]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Male']['Alg'] = ln[62]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Female']['Geom'] = ln[65]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Male']['Geom'] = ln[66]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Female']['Data'] = ln[67]
                    out_dict[countries[country]]['TIMSS'][filt][rnd][sjt]['Mean']['Male']['Data'] = ln[68]
        count = count + 1

    f.close()

def addDataCompare(file_name, filt):
    f = open(file_name)
    count = 0
    headers = ''
    for line in f:
        line = line[:-2]
        ln = line.split(",")
        if count == 0:
            headers = ln
        else:
            country = ln[1].replace('"','')
            rnd = ln[3]
            sjt = ln[4].replace('"','')
            if country in countries:
                out_dict[countries[country]]['Compare'][filt][rnd][sjt]['Mean']['Both']['All'] = ln[6]
                out_dict[countries[country]]['Compare'][filt][rnd][sjt]['StDev']['Both']['All'] = ln[7]
                out_dict[countries[country]]['Compare'][filt][rnd][sjt]['Mean']['Male']['All'] = ln[14]
                out_dict[countries[country]]['Compare'][filt][rnd][sjt]['Mean']['Female']['All'] = ln[15]
        count = count + 1
    f.close()

addData('one_round.csv', 'Any', 'both')
addData('round_match_1_PISA.csv', '1-2-3', 'PISA')
addData('round_match_2_PISA.csv', '1-2', 'PISA')
addData('round_match_3_PISA.csv', '1-3', 'PISA')
addData('round_match_4_PISA.csv', '2-3', 'PISA')
addData('round_match_1_TIMSS.csv', '1-2-3', 'TIMSS')
addData('round_match_2_TIMSS.csv', '1-2', 'TIMSS')
addData('round_match_3_TIMSS.csv', '1-3', 'TIMSS')
addData('round_match_4_TIMSS.csv', '2-3', 'TIMSS')
addDataCompare('round_match_1_comparison.csv', '1-2-3')
addDataCompare('round_match_2_comparison.csv', '1-2')
addDataCompare('round_match_3_comparison.csv', '1-3')
addDataCompare('round_match_4_comparison.csv', '2-3')
addDataCompare('round_match_5_comparison.csv', 'Any')
addDataCompare('round_match_6_comparison.csv', 'Any')
addDataCompare('round_match_7_comparison.csv', 'Any')

with open("take5_country_data.json", 'w') as outfile:
    json.dump(out_dict, outfile)

