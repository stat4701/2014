
# Detecting Medicare Claim Anomalies

# Part 1 - Data Acquisition and Exploration

## Problem Statement

This analysis is based on the challenge possed by [Cloudera Certified
Professional: Data Scientist
program](http://www.cloudera.com/content/cloudera/en/training/certification/ccp-
ds/challenge.html) for their graduating candidates.  The probelm statement
states the following:

"In the U.S., Medicare reimburses private providers for medical procedures
performed for covered individuals. As such, it needs to verify that the type of
procedures performed and the cost of those procedures are consistent and
reasonable. Finally, it needs to detect possible errors or fraud in claims for
reimbursement from providers. You have been hired to analyze a large amount of
data from Medicare and try to detect abnormal data -- providers, areas, or
patients with unusual procedures and/or claims."

Although this analysis is not aimed as a repsonce to this challenge, the real
world problem with curated data sources does tempt one to dig a little deeper.
The recent Wall Street Journal article on how [op 1% of medical providers
accounted for 14% of billing](http://online.wsj.com/news/articles/SB100014240527
02303456104579490043350808268?mg=reno64-wsj&url=http%3A%2F%2Fonline.wsj.com%2Far
ticle%2FSB10001424052702303456104579490043350808268.html) peaked my interest to
use the Cloudera use case as the topic for this post.


This post will be a 3 part series.  The firts one will discuss basic data
acquisition and prilimanary exploration of data.
The second will cover Predective Modeling and the last post will communicating
the results using a narrative (story telling) approach.
In this post, I will attempt to extract and explore statistics about the dataset
and present insights on abnormalities in procedur and claim trens.  As a
biproduct, I hope a data exploration and preparation workflow emerges that I can
generalize for use in future analysis.


## Data Acquisition

The following data sources were made available for this challenge.  They
summerize the procedures performed by a physician and the related charges sent
to Medicare for reimbersement.

1.  [Medicare Provider Charge Data: Inpatient](http://www.cms.gov/Research-
Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-
Charge-Data/Inpatient.html)

2.  [Medicare Provider Charge Data: Outpatient](http://www.cms.gov/Research-
Statistics-Data-and-Systems/Statistics-Trends-and-Reports/Medicare-Provider-
Charge-Data/Outpatient.html)

### Acquier Data

The grainularity of data for Inpatient and Outpatient is the same.  The
difference is in the size of the file.  The Inpatient file has more records as
the the volume of Inpatient procedure is more (which in itself can be an area of
exploration).    For logistical reasons, I have choosen the Outpatient dataset
first. The Outpatient data, (like the Inpatient dataset) is provided in two
bundles:  [Outpatient Charge Data, CY2011, Comma Separated Values (CSV)
version](http://www.cms.gov/Research-Statistics-Data-and-Systems/Statistics-
Trends-and-Reports/Medicare-Provider-Charge-Data/Downloads/OPPS_APC_CSV.zip) and
[National and State Summaries of Outpatient Charge Data, CY2011, Comma Separated
Values (CSV) version](http://www.cms.gov/Research-Statistics-Data-and-Systems
/Statistics-Trends-and-Reports/Medicare-Provider-Charge-
Data/Downloads/OPPS_NAT_STATE_SUM_CSV.zip).

The compressed zip file was downloaded and extracted locally.  It contains the
following files:

1.  Medicare_Provider_Charge_Outpatient_APC30_CY2011_v2.csv - Size 7MB

2.  Medicare_Charge_Outpatient_APC30_Summary_by_APC_CY2011_v2.csv - Size 2KB

3.  Medicare_Charge_Outpatient_APC30_Summary_by_APCState_CY2011_v2 - Size 107KB

We will start by initializing libraries for iPython Notebook

Initializing requiered iPython libraries

In[81]:

```
import numpy as np
import pandas as pd
import pandas.tools.rplot as rplot
import pylab as pl
import matplotlib as mpl
import matplotlib.pyplot as plt

#To be able to embed plots inline in the document
%matplotlib inline 
pd.set_option('display.notebook_repr_html', False)
pd.set_option('display.max_columns', 20)
pd.set_option('display.max_rows', 50)
```

Load data from the source.

The 'readCSV' is a good python/pandas api for interacting with csv or txt files.
A [robust set of libraries](http://pandas.pydata.org/pandas-docs/stable/io.html)
are avaialble that interact with JSON, SQL and HDFS5 amongst others.

[OpenRefine](http://openrefine.org/) is a tool that can be handy for data
cleansing, data exploration, and data transformation.

In[82]:

```
#set data source path
path = '/Users/DataSets/DetectingMedicareClaimAnomalies/DataSet/Extracted/Medicare_Provider_Charge_Outpatient_APC30_CY2011_v2.csv'

header_row = ['APC', 'HCP_Id', 'HCP_Name', 'HCP_St_Add', 'HCP_Add_City', 'HCP_Add_State', 'HCP_Add_Zip_Code', 'Hosp_Ref_Region_Desc', 'OPT_Srvc', 'Avg_Est_Submitted_Charges', 'Avg_Tot_Payments']

#get the data, specify that there are no headers as the default will read first row as headers
getData = pd.read_csv(path, header=True, names=header_row)
```

A good first step is to confirm that the data was read properly.  I usually
check the first and last few rows.  The output usually brings out incorrect,
improperly formatted, incomplete, incorrect, or duplicated records.

In[83]:

```
#confirm data extration
print('These are the first few rows >>>>>>>>>>>>>>>>>>>>>>>>>>>> ')
getData.head()
```


    These are the first few rows >>>>>>>>>>>>>>>>>>>>>>>>>>>> 




                                            APC  HCP_Id  \
    0  0012 - Level I Debridement & Destruction   20024   
    1  0012 - Level I Debridement & Destruction   30064   
    2  0012 - Level I Debridement & Destruction   30088   
    3  0012 - Level I Debridement & Destruction   30111   
    4  0012 - Level I Debridement & Destruction   40016   
    
                                                HCP_Name  \
    0                 CENTRAL PENINSULA GENERAL HOSPITAL   
    1   UNIVERSITY OF ARIZONA MEDICAL CTR-UNIVERSIT, THE   
    2                      BANNER BAYWOOD MEDICAL CENTER   
    3  UNIVERSITY OF ARIZONA MEDICAL CTR- SOUTH CAM, THE   
    4                                UAMS MEDICAL CENTER   
    
                                   HCP_St_Add HCP_Add_City HCP_Add_State  \
    0                      250 HOSPITAL PLACE     SOLDOTNA            AK   
    1              1501 NORTH CAMPBELL AVENUE       TUCSON            AZ   
    2                6644 EAST BAYWOOD AVENUE         MESA            AZ   
    3                       2800 EAST AJO WAY       TUCSON            AZ   
    4  4301 WEST MARKHAM STREET MAIL SLOT 612  LITTLE ROCK            AR   
    
       HCP_Add_Zip_Code Hosp_Ref_Region_Desc  OPT_Srvc  Avg_Est_Submitted_Charges  \
    0             99669       AK - Anchorage       994                 149.589749   
    1             85724          AZ - Tucson      1765                  50.135411   
    2             85206            AZ - Mesa        20                 112.400000   
    3             85713          AZ - Tucson        22                 152.045455   
    4             72205     AR - Little Rock      3166                  58.954668   
    
       Avg_Tot_Payments  
    0         36.623853  
    1         14.541841  
    2         23.736000  
    3         16.569091  
    4         13.573774  
    
    [5 rows x 11 columns]



Understand the list of values.  For example the claim count for top 10 APC and
States

In[84]:

```
#getData['APC'].value_counts()
APC_counts = getData['APC'].value_counts()
APC_counts[:10]
```




    0267 - Level III Diagnostic and Screening Ultrasound            2998
    0269 - Level II Echocardiogram Without Contrast                 2898
    0336 - Magnetic Resonance Imaging and Magnetic Resonance Angiography without Contrast    2855
    0265 - Level I Diagnostic and Screening Ultrasound              2739
    0377 - Level II Cardiac Imaging                                 2564
    0078 - Level III Pulmonary Treatment                            2304
    0368 - Level II Pulmonary Tests                                 2248
    0604 - Level 1 Hospital Clinic Visits                           2210
    0605 - Level 2 Hospital Clinic Visits                           2116
    0207 - Level III Nerve Injections                               2002
    dtype: int64



In[85]:

```
APC_counts[:10].plot(kind='barh')
```




    <matplotlib.axes.AxesSubplot at 0x160891650>




[![](https://pbs.twimg.com/media/BlAWicyCQAAsQh_.png:large)]


In[86]:

```
#getData['HCP_Add_State'].value_counts()
State_counts = getData['HCP_Add_State'].value_counts()
State_counts[:10]
```




    TX    3239
    CA    2983
    FL    2279
    PA    2264
    NY    2133
    IL    2087
    OH    2064
    MI    1424
    NC    1409
    GA    1393
    dtype: int64



In[87]:

```
State_counts[:10].plot(kind='bar')
```




    <matplotlib.axes.AxesSubplot at 0x150b05350>




[![](https://pbs.twimg.com/media/BlAXbGVCAAA5A-G.png:large)]


### Describe Data

#### Explore data statistics

Once I have confirmed that the data is coming in properly and observed its
general structure (string, floats, integrer field), a good second step is to
collect some descriptive satistics ont he dataset as a whole.

Grouping the desriptive statistics by a field you are particularly interested
helps form a general impression about the way that fields trends in the dataset.

In this case the [APC or Ambulatory Payment
Classifications](http://en.wikipedia.org/wiki/Ambulatory_Payment_Classification)
field is a good 'groupby' field.  Note: The APC claims are related to a
Hospitals and reffering hospitals.  Phycisians are remberssed through a
different system.

In[93]:

```
APC_describe = getData.groupby("APC").describe()
APC_describe[:10]
```




                                                            HCP_Id  \
    APC                                                              
    0012 - Level I Debridement & Destruction  count     290.000000   
                                              mean   271517.668966   
                                              std    149733.565114   
                                              min     20024.000000   
                                              25%    140158.750000   
                                              50%    260067.000000   
                                              75%    390096.250000   
                                              max    670034.000000   
    0013 - Level II Debridement & Destruction count    1479.000000   
                                              mean   269293.345504   
    
                                                     HCP_Add_Zip_Code  \
    APC                                                                 
    0012 - Level I Debridement & Destruction  count        290.000000   
                                              mean       50829.382759   
                                              std        30624.874347   
                                              min         1069.000000   
                                              25%        27116.500000   
                                              50%        55087.500000   
                                              75%        75584.500000   
                                              max        99669.000000   
    0013 - Level II Debridement & Destruction count       1479.000000   
                                              mean       48892.743746   
    
                                                        OPT_Srvc  \
    APC                                                            
    0012 - Level I Debridement & Destruction  count    290.00000   
                                              mean     946.30000   
                                              std     2256.49538   
                                              min       11.00000   
                                              25%       28.00000   
                                              50%      132.50000   
                                              75%      828.00000   
                                              max    24527.00000   
    0013 - Level II Debridement & Destruction count   1479.00000   
                                              mean     292.16430   
    
                                                     Avg_Est_Submitted_Charges  \
    APC                                                                          
    0012 - Level I Debridement & Destruction  count                 290.000000   
                                              mean                   91.129202   
                                              std                    95.808811   
                                              min                    12.643750   
                                              25%                    34.982094   
                                              50%                    62.350455   
                                              75%                   113.893622   
                                              max                   841.900000   
    0013 - Level II Debridement & Destruction count                1479.000000   
                                              mean                  262.557685   
    
                                                     Avg_Tot_Payments  
    APC                                                                
    0012 - Level I Debridement & Destruction  count        290.000000  
                                              mean          17.767613  
                                              std            4.541913  
                                              min            7.305000  
                                              25%           14.644603  
                                              50%           16.072068  
                                              75%           19.526026  
                                              max           36.623853  
    0013 - Level II Debridement & Destruction count       1479.000000  
                                              mean          56.142408  
    
    [10 rows x 5 columns]



#### Visual Exploration of Data

A quick visualization of the loaded data can also provide leads to possible
areas of deeper exploration.  As in this case, we are looking at claim outliers,
we should pay special attention to data that are detached from the primary
clustering.

In[89]:

```
#visually explore the datafrom pandas.tools.plotting import scatter_matrix

pd.scatter_matrix(getData, alpha=0.2, figsize=(8, 8), diagonal='kde')
```




    array([[<matplotlib.axes.AxesSubplot object at 0x15c06d950>,
            <matplotlib.axes.AxesSubplot object at 0x15f40bf10>]], dtype=object)




[![](https://pbs.twimg.com/media/BlAXESBCYAEhyh8.png:large)]


As is clear from the graphs that infact there is a seperation in the claims.
Most of the claim payments are clustered tightly together while a smaller set
breaks away towards the higher end.  The pattern in the data for HCP_Id and
Avg_Tot_Payment for example, has the approximatly the same trend as the one for
HCP_Add_Zip_Code.  This may imply that trend projected by the grpah is
independent of geography.

Looking at the scatter plots, claims that had and an Avg_Est_Submitted_Charges
above $ 200,00 for which Avg_Tot_Payments were above $ 1500 are another are of
analysis.

A sense of the number of records for the fields one is most interested in can be
derived by ploting them individually.  The graphs below, for example, shows the
APCs with most records are from Cardiac Imaging, MRIs and Cardiovascular
studies.

In[90]:

```
getData.groupby('APC').Avg_Est_Submitted_Charges.sum().plot(kind='barh', color='gold')
```




    <matplotlib.axes.AxesSubplot at 0x150bc9490>




[![](https://pbs.twimg.com/media/BlAWaLTCEAEHEDK.png:large)]


In[91]:

```
bp = getData.boxplot(column='Avg_Tot_Payments', by='HCP_Add_State', grid=False)
for i in [1,2,3]:
    y = getData.Avg_Tot_Payments[getData.HCP_Add_State==i].dropna()
    # Add some random "jitter" to the x-axis
    x = np.random.normal(i, 0.04, size=len(y))
    pl.plot(x, y, 'r.', alpha=0.2)
```



[![](https://pbs.twimg.com/media/BlAW2LTCUAEeKEg.png:large)]


# Next Predictive Modeling, Communicating Results ...

In[ ]:

```

```
