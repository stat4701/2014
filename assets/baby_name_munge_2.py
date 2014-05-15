import csv
import json

names = {'M': {}, 'F': {}} # dict to hold all names from file and counts

states = ['AK', 'AR', 'AZ', 'AL', 'CA', 'CT', 'CO', 'DE', 'FL', 'GA',
          'HI', 'IL', 'IA', 'IN', 'ID', 'KS', 'KY', 'LA', 'MA', 'MD',
          'MS', 'MI', 'MO', 'MN', 'MT', 'NE', 'NV', 'NC', 'ND', 'NY',
          'NJ', 'NM', 'NH', 'OH', 'OR', 'OK', 'PA', 'RI', 'SC', 'SD',
          'TX', 'TN', 'UT', 'VT', 'VA', 'WV', 'WY', 'WI', 'WA', 'ME', 'DC']

def getNames(state):
    #Total name counts for each gender, for given file
    file_name = 'namesbystate/' + state + '.TXT'
    with open(file_name, 'rb') as fname:
        state_data = csv.reader(fname)
        for row in state_data:
            if row[3] in names[row[1]]:
                names[row[1]][row[3]] = names[row[1]][row[3]] + int(row[4])
            else:
                names[row[1]][row[3]] = int(row[4])
#Loop through states, to get names and counts by gender
for i in states:
    getNames(i)

#Get sorted list of names (highest name counts first)
men = sorted(names['M'], key=names['M'].__getitem__, reverse=True)
women = sorted(names['F'], key=names['F'].__getitem__, reverse=True)

#Get top 1000 names for each gender
m_subset = men[:1000]
f_subset = women[:1000]

def getTotalCounts(gender, subset):
    #For name subset list and gender, total names in top 1000 and total all names
    total_1000 = 0
    total = 0
    for name in names[gender]:
        if name in subset:
            total_1000 = total_1000 + names[gender][name]
        total = total + names[gender][name]
    return (total_1000, total)

#Get counts for top 1000 names and all names
m_counts = getTotalCounts('M', m_subset)
f_counts = getTotalCounts('F', f_subset)

#Create and print string with count information, for reference
m_string = 'For men, the top 1000 names account for ' + str(float(m_counts[0])/float(m_counts[1])*100) + ' percent of the names in the data'
f_string = 'For women, the top 1000 names account for ' + str(float(f_counts[0])/float(f_counts[1])*100) + ' percent of the names in the data'
print(m_string)
print(f_string)

#Create single list with all names from top 1000 male and female names
all_subset = list(set(m_subset) | set(f_subset))

out_data = {}
total_data = {}
start_year = 1910
end_year = 2012

def createEmptyState():
    #Creates an empty dict to hold values for each name
    state_dict = {}
    init_list = [0] * (end_year - start_year + 1)
    for name in all_subset:
        state_dict[name] = {'M': [], 'F': []}
        state_dict[name]['M'] = list(init_list)
        state_dict[name]['F'] = list(init_list)
    return state_dict
        

def getData(state):
    #For given file, loops through rows and puts count for name for year in data_dict
    file_name = 'namesbystate/' + state + '.TXT'
    with open(file_name, 'rb') as fname:
        state_data = csv.reader(fname)
        data_dict = createEmptyState()
        total_dict = {}
        init_list = [0] * (end_year - start_year + 1)
        total_dict = {'M': [], 'F': []}
        total_dict['M'] = list(init_list)
        total_dict['F'] = list(init_list)
        for row in state_data:
            year_ix = int(row[2]) - start_year
            if row[3] in all_subset:
                data_dict[row[3]][row[1]][year_ix] = int(row[4])
            total_dict[row[1]][year_ix] = total_dict[row[1]][year_ix] + int(row[4])
        for name in data_dict:
            if name.lower() not in out_data: #Make names lower for dropdown in d3, it is case sensitive
                out_data[name.lower()] = {}
            out_data[name.lower()][state] = data_dict[name]
        total_data[state] = total_dict
#Loop through states to get all name counts in out_dict
for i in states:
    getData(i)

#Make names lower for dropdown in d3, it is case sensitive
lower_names = [x.lower() for x in all_subset]

#Write data to file for use with d3 map
with open("json_baby_names_2000.json", "w") as out:
    json.dump({'name_list': lower_names, 'total': total_data, 'name': out_data}, out)


