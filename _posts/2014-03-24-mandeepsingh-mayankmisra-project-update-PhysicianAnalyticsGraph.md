
# Physician Affinity Graph

## Summary
This is an attempt to recreate and expand upon the work done by [Fred
Trotter](www.fredtrotter.com) on building a network graph of pysicians and
orgainizations envolved in providing health care services to Medicare patients.
The [DocGraph](www.docgraph.org) was first presented at the
[Strata](http://strata.oreilly.com/2012/11/docgraph-open-social-doctor-
data.html) conference in 2012.  This initative crossed a big milestone wherein
it applied social network analysis on a network that is not managed formally
within a propritory system (like Facebook and LinkedIn).  FOIA enabled Open
datasets were used to decipher relationships between healthcare provider
entities. As far as we have researched, the data nor the visualization of the
graph is publically available yet.

## What do we hope to answer?
In our work, we hope to recreate the graph but with additional considerations
that will help answer the followin questions:

1. Who are the most influential doctors for a particular disease area in a
specific geography?
2. Can we apply ranking or an influence score to the healthcare provider?
3. Is there a way, using these data, to develop a 'Key Opinion Leader' KOL
recommendation engine for payers, pharmaceutical companies, patients,
researchers and academia?

This will be achieved by clustering the data based on:

- Providers (NPI, name, city, state) view (by Geo and Specialty)
- Geography (city and state) view (by HCP and Specialty)
- Specialties view (by Geo and HCP)



## Data Sources

The following datasets and sources were identified for this analysis:

1. [National Plan and Provider Enumeration System](http://nppes.viva-
it.com/NPI_Files.html) data from [Centers for Medicare and Medicaid Services](ht
tp://en.wikipedia.org/wiki/Centers_for_Medicare_and_Medicaid_Services) (CMS).
This data set captures every provider, plan, and clearinghouse involved in
enabling healthcare in the United States.  The [Healthcare Insurance Portability
and Accountability Act (HIPPA) of 1998](http://www.cms.gov/Regulations-and-
Guidance/HIPAA-Administrative-Simplification/HIPAAGenInfo/index.html) requires
every  entity that sends a claim (raises a bill) for providing healthcare to
acquire a NPI.  This number is unique as a social security number an dis
referenced across public and private systems.  The NPPES data is keyed on
[National Provider
Identifier](http://en.wikipedia.org/wiki/National_Provider_Identifier) (NPI).
The NPEES data is a CSV file that is in exess of 2 GB when uncompressed. It
contains one record per covered entity, which include nurse pratitioners,
community health centers, hospitals, and other care providers who are not
pysicians.  NPI information is also available through API calls via
[BloomAPI](http://www.bloomapi.com/documentation) and
[DocNPI](http://docnpi.com/).  BloomAPI is opensource, more up-to-date
(4-6months after CMS releases the data) but lacks the aility to look up doctors
by type (e.g. geography or specialization). This data is available for 2001,
2010 and 2011. [The National Provider Identifier (NPI): What You Need to
Know](http://www.cms.gov/Outreach-and-Education/Medicare-Learning-Network-
MLN/MLNProducts/downloads/NPIBooklet.pdf) booklet is a good resource to
understand the NPI categories.  In the grpah database paralance, this is a node
database.  Each record contains a mailing and the practise address for the HCP.


2. [DocGraph Edge Database v1.0 Open Source](http://notonlydev.com/product
/docgraph-edge-database-v1-0-open-source/).  Download for a token of $1.  This
data is available for 2011 only.  As the name suggests, this is a edge database.
Each record in this database captures the  occurences where a claim was made for
the same patient by two health care providers (HCP) in a rolling 30 day time
period.  The two HCPs are picked up only if they have had 11 or more 'shared'
patients for which Medicare was billed.  The 11 number is a CMS standard to
obfescate identifying individual patient by their referal patterns.  A record in
this data set is of the form: {1112223334,5556667778,1100}.  The first value in
the NPI of the HCP who provided care the first.  The second value is the NPI who
provided care subsequently.  The third value is the number of time this occured
in the past rolling 30 days for that year.  The dataset documentation lists the
assumes as follows:
    - If Provider A sees a patient on January 15, and Provider B sees the same
patient on February 15, then that counts as “+1.”
    - If the same patient sees Doctor A on January 15, Doctor B on February 15
and then again on June 15 and July 15, then that counts as “2″ referrals in this
dataset. When a referral relationship has a score of 1,100 we cannot know if
this was 11 patients with 100 referral instances, or 1,100 patients with 1
referral instance, or 10 patients with 10 referral instances and 1 patient with
1,090 referral instances. The whole point here is that we have a score that
approximates the strength of the relationship between two entities in the NPI
database, and for that purpose it does not really matter what kind of patient
flow is being indicated.


3. [Physician Referral Patterns – 2009, 2010,
2011](https://questions.cms.gov/faq.php?faqId=7977) : These files represent 3
years of data showing the number of referrals from one physician to another.
This dataset was made available as a FOIA request but seems to have been
redacted recently.  The source location is still up but points to a dead link.
We have mentioned it here for reference.  The data may not be available due to a
technical issues at the time this work was carried out.


4. [Medicare Part D Prescribing Data 2011 & Medicare Part D Prescribing Data
(Patients 65 or Older) 2011](https://projects.propublica.org/data-store/) :
These data, made available by [ProPublica](www.propublica.org), include all
drugs prescribed by doctors 11 or more times that year to Part D patients,
including those 65 and older. A lookup file is provided to match unique
prescriber ID to a practitioner's DEA or NPI number or other identifier.  The
NPI number will be used to tie this to the other datasets.  This data is
available for 2011 only.


## Methedology

### Establish Relationships
   - The NPI will be used as the cross reference key to join the data sets.
   - The DocGraph Edge dataset will be used to establish the relationship
between HCPs.  Here, the occurence count field will be used as the weigth in our
Machine Learning algorithms.  The more the count, the tighter the relationship.
   - The NPPES data has the practise and the mailing address for each provider
(HCP).  These will be used to connect the data topologically.
   - The NPI will also be linked to the ProPublica data set on drug
prescriptions.  The looup file for matching NPI to DEA (prescriber id) will be
used to join NPPES and Propublica datasets.
   - The drug prescriptions will be linked to Pharmaceutical companies using.
An assumption is made that the prescription history of a HCP is a indicator of
the pharma-physician relationship.
   - For establishing a Speciality, we will use NPPES taxonomy codes and enrich
them using [Health Care Provider Taxonomy](http://codelists.wpc-
edi.com/mambo_taxonomy_2_pre_production.asp). The CSV can be [downloaded here](h
ttp://www.nucc.org/index.php?option=com_content&view=article&id=107&Itemid=132)




### Data Wrangling


### Data Modeling


### Analysis


### Visualization

## Challenges and concerns

- Ideally we would have liked to use the [American Medical Association Physician
Masterfile](http://www.ama-assn.org/ama/pub/about-ama/physician-data-resources
/physician-masterfile.page).  This file has nationa level data on each
physician, including demographic, education/training and practice information.
The AMA website describes this file as including "current and historical data
for more than 1.4 million physicians, residents, and medical students in the
United States. This figure includes approximately 411,000 graduates of foreign
medical schools who reside in the United States and who have met the educational
and credentialing requirements necessary for recognition".  This is not a open
dataset and not an option in absence of a budget.  Our choice was limted to the
NPPES data or its derivations.  Although all practitioners and healthcare
providers that participate in Medicare, Medicaid should have an NPI, the depth
and completness of data for physicians is not at par with the AMA master file.

- This exercise is based on Medicare data and therfore may not provide a
complete picture.

## Enabling technologies

- Gephi
- D3.js
- Python
- R:  For analysis we referenced the work done by [Anthony Damico on public data
sets](http://www.asdfree.com/search/label/national%20plan%20and%20provider%20enu
meration%20system%20%28nppes%29) specially in terms of using R code.
- Tableau (maybe)
- MySQL
- Neo4j (maybe)
- GitHub


#Strech goal

- If there is time, we would like to add population data for state/city for
broaded analysis on Medicare claims and population features of a geography.
- Use TIGER to plot Cencus data long/lat http://www.census.gov/geo/maps-
data/data/tiger.html
- This will enable future analysis on corelation between weather patterns,
presence of public spaces (park and rec), numberof fast food stores, public
transport, facilities for the elderly

Research:
DocGraph Neo4J file using the Neo4J version 2.0 file. It includes the following
nodes:

organizations
specialties - taxonomy based
Providers - NPI/name/address/city/state
Locations - unique city/state/country

Code https://github.com/davidfauth/neo4JDocGraph
Data http://bit.ly/19ctbaq


We can also use the summary data on procedures performed and billed by providers
in 2011, as well as how much Medicare reimbursed

The following questions have been posed by a Cloudera sponsored DataScience
challenge.  We can aim to answer these and add more insights by including the
NPI and Prescription info:

We think that some providers and regions are consistently billing too much for
procedures or billing for too many procedures, perhaps inadvertently.
Which procedures have the highest relative variance in cost?
For each procedure, consider the average amount claimed by each provider. Some
providers will have the highest average amount. Which three providers were the
highest for the largest number of procedures?
Some providers and regions are likely to be different in more subtle ways.
Based on amount and type of procedures claimed, which three providers and
regions are least like the others?
Can you briefly explain what seems to be different about these?
We have a lot of individual patient claim data. Our staff have identified
several that look unusual -- they could be errors or fraud or simply unique
patient contexts that are worth review.
Given this information, identify another 10,000 patients that seem most likely
to need review.
Can you briefly describe some common features in these patients?
More here:  http://www.cloudera.com/content/cloudera/en/training/certification
/ccp-ds/challenge/register.html

# Limitations

### Data are dirty (.gov data are very dirty)

Health and Humas Service itself acknowledge that [Improvements Are Needed To
Ensure Provider Enumeration and Medicare Enrollment Data Are Accurate, Complete,
and Consistent](http://oig.hhs.gov/oei/reports/oei-07-09-00440.asp)



    
