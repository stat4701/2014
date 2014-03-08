---
layout: post
title: Celene - Project update
description:
tags: blog
---
<section>
	<section>
### Project update
* Set up package structure<br>
* Wrote python script to pull all cases from Desk API<br>
* Grabbed the cases<br>
-> required pulling 'next' URL field from each page until that field was `None`<br>
* Converted it to pandas DataFrame<br>
* Started playing around with different ways to slice data (see below)<br>
* Discovered that one of the dictionary fields had nested fields, which contained information that I wanted but didn't get picked up as a column in a DataFrame<br>
-> so then had to adjust data collecting script to unnest them<br>
-> this was trickier than expected because sometimes there were 'None' values which I had to figure out a way to handle while still not picking up the extraneous (meaningless) fields<br>
-> resulted in a lot of practice with the notation for lists of dicts
<br><br>

Note: ```python def __init__(self)``` not included because it contains auth keys<br><br>


```python

from requests_oauthlib import OAuth1 as oauth
import requests
import logging

import simplejson as json

log = logging.getLogger('desk')


class DeskCases(object):

	[...]

    def get_request(self, url):
        resp = requests.get(url, auth=self.auth)
        if resp.ok != True:
            log.error('Error in retrieval')
        return resp

    def get_all_cases(self):
        # retrieve first page
        url = "{0}/api/v2/cases?page=1&per_page=100".format(self.api_url)
        resp = self.get_request(url)
        resp_dict = resp.json()

        parsed_dict = {}
        # separate _links for each entry in first page; *note that there is still an aggregated _links key in the result*
        for entry in resp_dict["_embedded"]["entries"]:

            links_dict = {
                u'customer': entry["_links"]["customer"]["href"], u'attachments': entry["_links"]["attachments"]["count"], \
                u'self': entry["_links"]["self"]["href"], u'notes': entry["_links"]["notes"]["count"], \
                u'replies': entry["_links"]["replies"]["count"], u'message': entry["_links"]["message"]["href"], \
                u'history': entry["_links"]["history"]["href"]
                }

            if entry["_links"]["assigned_user"] is not None:
               links_dict[u'assigned_user'] = entry["_links"]["assigned_user"]["href"]
            else:
                links_dict[u'assigned_user'] = None

            if entry["_links"]["assigned_group"] is not None:
                links_dict[u'assigned_group'] = entry["_links"]["assigned_group"]["href"]
            else:
                links_dict[u'assigned_group'] = None

            #links_dict = {
            #    'customer': entry["_links"]["customer"]["href"], 'attachments': entry["_links"]["attachments"]["count"], \
            #    'self': entry["_links"]["self"]["href"], 'notes': entry["_links"]["notes"]["count"], \
            #    'replies': entry["_links"]["replies"]["count"], 'assigned_group': entry["_links"]["assigned_group"]["href"], \
            #    'assigned_user': entry["_links"]["assigned_user"]["href"], 'message': entry["_links"]["message"]["href"], \
            #    'history': entry["_links"]["history"]["href"]
            #    }
            #if len(parsed_dict) == 0:
            #    parsed_dict = dict(entry.items() + links_dict.items())
            #else:
            #parsed_dict.items()

        #parsed_dict = dict(entry.items() + links_dict.items())
        del entry["_links"]
        del entry["custom_fields"]
        del entry["locked_until"]
        del entry["description"]


        parsed_dict = dict(entry.items() + links_dict.items())
        parsed_dict = { 'entries': [ parsed_dict ] }

        #modified_entry = {entry + links_dict}
        #parsed_dict = {'entries': entry + links_dict}

        next_link = resp_dict["_links"]["next"]["href"]

        #cases_dict = {'entries': parsed_dict}

        # loop through subsequent pages
        while next_link is not None: # or null?
            url = "{0}{1}".format(self.api_url, next_link)
            resp = self.get_request(url)
            resp_dict = resp.json()

            # loop through every entry on the page to parse _links
            for entry in resp_dict["_embedded"]["entries"]:
                links_dict = {
                        u'customer': entry["_links"]["customer"]["href"], u'attachments': entry["_links"]["attachments"]["count"], \
                        u'self': entry["_links"]["self"]["href"], u'notes': entry["_links"]["notes"]["count"], \
                        u'replies': entry["_links"]["replies"]["count"], u'message': entry["_links"]["message"]["href"], \
                        u'history': entry["_links"]["history"]["href"]
                        }

                if entry["_links"]["assigned_user"] is not None:
                   links_dict[u'assigned_user'] = entry["_links"]["assigned_user"]["href"]
                else:
                    links_dict[u'assigned_user'] = None

                if entry["_links"]["assigned_group"] is not None:
                    links_dict[u'assigned_group'] = entry["_links"]["assigned_group"]["href"]
                else:
                    links_dict[u'assigned_group'] = None

                del entry["_links"]
                del entry["custom_fields"]
                del entry["locked_until"]
                del entry["description"]

                modified_entry = dict(entry.items() + links_dict.items())

                parsed_dict["entries"].append(modified_entry)


            if resp_dict["_links"]["next"]:
                next_link = resp_dict["_links"]["next"]["href"]
            else:
                break

        return parsed_dict

 ```

### Preliminary exploratory analyses

```python
>>> df_emails.columns
Index([u'active_at', u'assigned_group', u'assigned_user', u'attachments', u'blurb', u'created_at', u'customer', u'external_id', u'first_opened_at', u'first_resolved_at', u'history', u'id', u'labels', u'language', u'message', u'notes', u'opened_at', u'priority', u'received_at', u'replies', u'resolved_at', u'self', u'status', u'subject', u'type', u'updated_at'], dtype='object')

>>> df_emails = df[df['type']=='email']
>>> df_emails.groupby('assigned_user').type.count()
assigned_user
/api/v2/users/15969134     964
/api/v2/users/17044883      43
/api/v2/users/17061360      48
/api/v2/users/17233390     269
/api/v2/users/18722989     234
/api/v2/users/18723040     263
/api/v2/users/20009893     132
/api/v2/users/21015119       3
/api/v2/users/21097337     249
/api/v2/users/21119707    1779
/api/v2/users/21192331      60
/api/v2/users/21202435      13
/api/v2/users/21564094      15
/api/v2/users/21743396       1
/api/v2/users/21806616       8


>>> df_emails.describe()
       attachments           id        notes     priority      replies
count  7262.000000  7262.000000  7262.000000  7262.000000  7262.000000
mean      0.173644  4298.381025     0.187139     3.767970     2.627926
std       0.870964  2516.498128     0.499370     0.900965     2.567064
min       0.000000   101.000000     0.000000     1.000000     0.000000
25%       0.000000  2050.250000     0.000000     4.000000     1.000000
50%       0.000000  4243.500000     0.000000     4.000000     2.000000
75%       0.000000  6477.500000     0.000000     4.000000     3.000000
max      28.000000  8743.000000     8.000000     9.000000    32.000000


>>> df_emails.groupby('assigned_user').sum()
                        attachments        id  notes  priority  replies
assigned_user
/api/v2/users/15969134          173   2233292    165      3842     2811
/api/v2/users/17044883            4     75934      2       172       84
/api/v2/users/17061360            5    103844      1       192      142
/api/v2/users/17233390           84    696378     29      1083      963
/api/v2/users/18722989           70    838498     50       937      851
/api/v2/users/18723040           96   1211308     37      1053     1117
/api/v2/users/20009893           27    420813     16       531      401
/api/v2/users/21015119            0      7643      1        12       11
/api/v2/users/21097337           45   1987725    197      1064      887
/api/v2/users/21119707          481  10566131    455      7189     6790
/api/v2/users/21192331           13    329922     20       245      241
/api/v2/users/21202435           18     93102      7        53       84
/api/v2/users/21564094            5    113735     26        66       80
/api/v2/users/21743396            0      8119      0         4        5
/api/v2/users/21806616            1     69541      3        32        8


>>> df_emails.groupby(['customer', 'id']).sum()
                                  attachments  notes  priority  replies
customer                    id
/api/v2/customers/100226150 4919            2      0         4       11
/api/v2/customers/100339567 4920            0      1         4        1
                            5911            0      0         4        2
/api/v2/customers/100383348 4922            0      0         4        1
                            4995            0      0         4        5
                            4996            5      2         4       14
                            5011            0      0         4        5
                            5015            0      0         4        2
                            5016            0      0         4        3
                            5042            2      0         4        8
                            5070            0      0         4        1
                            5077            0      0         4        2
                            5114            0      0         4       13
                            5145            2      0         4        2
                            5354            0      2         4       12
                            5367            0      0         4        4
                            5386            0      0         4        2
                            5453            0      0         4        3
                            5487            0      1         4        5
                            5488            0      0         4        3
                            6368            0      0         4        4
                            6369            0      0         4        3
                            6439            0      0         4        5
                            6483            0      0         4        2
                            6686            0      1         4        4
                            6743            0      0         4        1
                            6778            0      0         4        1
                            6803            0      0         4       13
                            6804            0      0         4        2
                            6806            4      0         4       26
                            6833            0      0         4        6
                            6868            0      0         4        3
                            6895            0      1         4        4
                            7002            0      0         4        5
                            7398            0      0         4        2
                            8332            0      1         4        9
                            8394            0      1         4        2
/api/v2/customers/100406118 4929            0      0         4        1
/api/v2/customers/100422946 4932            1      1         4        2
/api/v2/customers/100534901 4937            0      0         4        2
                            5659            0      0         4        8
                            5662            0      0         4        2
/api/v2/customers/100589766 4938            0      0         4        3
                            7856            0      0         4        2
/api/v2/customers/100592460 4939            0      0         4        1
/api/v2/customers/100655862 4943            0      1         4        1
/api/v2/customers/100689655 4947            0      0         4        2
                            8170            0      0         5        1
                            8429            0      1         5        2
                            8581            0      0         5        1
/api/v2/customers/100706475 4948            0      0         4        2
/api/v2/customers/100729640 4949            0      0         4        4
/api/v2/customers/100868239 4951            0      0         4        7
                            7331            0      0         4        2
/api/v2/customers/100901496 4953            0      0         4        3
                            5353            0      0         4        5
/api/v2/customers/100914598 4954            0      1         4        3
                            4977            0      0         4        1
/api/v2/customers/100931583 4956            0      0         4        2
                            4970            0      0         4        4
                                          ...    ...       ...      ...

[7262 rows x 4 columns]

```

<br><br>

### Next steps
1. More exploratory analyses<br>
-> Filter out the non-email type cases<br>
-> Figure out how to work with the dates in a meaningful way (just discovered `pandas.to_datetime()` function which works here)<br>
-> Splice by user ID field, so that I can do some comparisons between support case entries and account info (such as length of time as customer, # hosts, amount paying, etc.)
-> Would be neat to get a measure of `importance` for our customers, assuming that the ones that write in the most with requests and bugs are the ones that depend on us most<br>
2. Explore and learn how to use Bokeh and D3<br>



</section>
</section>
