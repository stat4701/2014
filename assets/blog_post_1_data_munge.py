import json

json_arr = [] #Initialize array to hold json output
years = [2013, 2009, 2005, 2001, 1997, 1993] #Years to include data for
gov_subcats = {'Federal hospitals': 'Federal', #Government doesn't have subcats, adding manually
               'Department of Defense': 'Federal',
               'U.S. Postal Service': 'Federal',
               'Other Federal government': 'Federal',
               'State government education': 'State',
               'State hospitals': 'State',
               'State government general administration': 'State',
               'Other State government': 'State',
               'Local government education': 'Local',
               'Local government utilities': 'Local',
               'Local government transportation': 'Local',
               'Local hospitals': 'Local',
               'Local government general administration': 'Local',
               'Other local government': 'Local'};

def loadJobData(year, is_proj):
    """
    Given a year and a boolean representing whether the data is preliminary or not
    (needed because the 2013 data is still preliminary), this function loops through
    the file for the year (located in the same directory), adding a dict for each job type
    The data was manually gathered from the data.bls.gov/cgi-bin/dsrv?ce widget.
    """
    jobs = []
    f = open('jobdata'+str(year)+'.csv')
    for line in f:
        if is_proj: #Remove (P) from the end of the file if it's preliminary data
            line_arr = line[:-4].split(',')
        else:
            line_arr = line[:-1].split(',')
        if line_arr[1].strip() == 'No Data Available': #Some data is missing, set value to 0 in this case
            val = 0
        else:
            val = float(line_arr[1])/1000 #Data comes in thousands, divide by 1000 to get millions
        in_data = {'series': line_arr[0], 'value': val}
        jobs.append(in_data)  
    f.close()
    return jobs

def loadCategoryData():
    """
    Returns the data on the job categories, read in from a file downloaded from this site:
    download.bls.gov/pub/time.series/ce/ce.industry
    """
    categories = {}
    f = open('categories.txt')
    for line in f:
        line_arr = line[:-1].split("\t")
        categories[line_arr[0]] = {'naics': line_arr[1], 'name': line_arr[3], 'level': line_arr[4]} 
    f.close()
    return categories

def loadSectorData():
    """
    Returns the data on the industry sectors, read in from a file downloaded from this site:
    download.bls.gov/pub/time.series/ce/ce.supersector
    """
    sector = {}
    f = open('sector.txt')
    for line in f:
        line_arr = line[:-1].split("\t")
        sector[line_arr[0]] = line_arr[1]
    f.close()
    return sector

def loadGroupData():
    """
    Returns the data on the overall category, file manually created based on original graphic:
    www.npr.org/news/graphics/2014/01/alljobs.gif
    """
    group = {}
    f = open('groups.txt')
    for line in f:
        line_arr = line[:-1].split("\t")
        group[line_arr[0]] = line_arr[1]
    f.close()
    return group

def addCategoryData(jobs, cats):
    """
    Adds the category data to the job type/value data and returns the jobs
    """
    for i in range(0, len(jobs)):
        #The BLS website describes the series coding. The third through tenth characters map
        # to the categories data.
        category = jobs[i]['series'][3:11]
        jobs[i]['level'] = cats[category]['level']
        jobs[i]['name'] = cats[category]['name']
        jobs[i]['naics'] = cats[category]['naics']
    return jobs

def addSectorGroupData(jobs, sectors, group):
    """
    Adds the sector and group data to the job type/value data and returns the jobs
    """
    for i in range(0, len(jobs)):
        #The BLS website describes the series coding. The third and fourth characters map
        # to the series/group data.
        sector = jobs[i]['series'][3:5]
        jobs[i]['cat'] = group[sector]
        #Government jobs don't have sectors listed, take care of this exception manually
        if jobs[i]['name'] in gov_subcats and jobs[i]['cat'] == 'Government':
            jobs[i]['subcat'] = gov_subcats[jobs[i]['name']]
        else:
            jobs[i]['subcat'] = sectors[sector]
    return jobs

def getJobsSubset(jobs):
    """
    Returns the subset of the jobs at the level we want for the chart. What was needed
        was found by manual inspection of the original graphic
    """
    subset = []
    for i in range(0, len(jobs)):
        #We generally want to see the jobs with naics codes that are three digits long
        if len(jobs[i]['naics']) == 3:
            subset.append(jobs[i])
        #Take care of exceptions, government jobs don't have naics codes
        if jobs[i]['cat'] == 'Government' and jobs[i]['level'] == '5':
            subset.append(jobs[i])
        #Take care of a few exceptions to the exceptions
        if jobs[i]['name'] == 'U.S. Postal Service' or jobs[i]['name'] == 'State government education' or jobs[i]['name'] == 'Local government education':
            subset.append(jobs[i])
    return subset

def addToJson(arr, jobs, year):
    """
    Returns the array to be output as json, with the specific fields needed for the year requested
    """
    arr.append({'year': year})
    curr_ix = len(arr)-1
    for i in range(0, len(jobs)):
        arr[curr_ix]['val'+str(i)] = {'name': jobs[i]['name'],
                                      'value': jobs[i]['value'],
                                      'cat': jobs[i]['cat'],
                                      'subcat': jobs[i]['subcat']}
    return arr

def addYearData(year, is_proj):
    """
    Main function, given a year, it calls all above functions to load in the data for the year,
        add to it the categories and industries, and then add it to the json array
    """
    global json_arr
    job = loadJobData(year, is_proj)
    cats = loadCategoryData()
    sector = loadSectorData()
    group = loadGroupData()
    jobs = addCategoryData(job, cats)
    jobs = addSectorGroupData(job, sector, group)
    sub_jobs = getJobsSubset(jobs)
    json_arr = addToJson(json_arr, sub_jobs, year)

#Add data to json array for each year specified in years array
for i in range(0, len(years)):
    is_proj = False
    if years[i] == 2013: #2013 is still preliminary
        is_proj = True
    addYearData(years[i], is_proj)

#Write json array to file
with open ('jobs_json_array.txt', 'w') as outfile:
    json.dump(json_arr, outfile)
