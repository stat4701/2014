import pandas as pd
import numpy as np
from pandas import *
import os
import psycopg2
import sys
import brewer2mpl
import pylab as pl
import matplotlib as plt
import matplotlib
import matplotlib.pyplot as plt
import scipy as sc
from scipy import stats
from scipy.stats import norm
from pylab import *
from numpy import float64
from mpltools import style
from mpltools import special
import statsmodels.api as sm
from statsmodels.sandbox.regression.predstd import wls_prediction_std
import statsmodels.formula.api as smf
from statsmodels.formula.api import ols
from sklearn import mixture
import random
from sklearn.cluster import KMeans

pd.set_option('max_rows',4000)
pd.set_option('max_columns',1000)
pandas.set_option('precision',3)
os.chdir('c:/users/jp/desktop/dropbox/school/spring2014/edav/Poker data/NEW_TRY/StageB')

def login(number):
	db_name = 'EDAV_'+str(number) # the databases are EDAV_1,...,EDAV_4
	connection = psycopg2.connect("dbname=" + db_name + " user=postgres password=postgrespass")
	mark = connection.cursor()
	return mark

def rename_headers(table_headers, record): # RENAME COLUMNS
	column_names = 'select column_name from information_schema.columns where table_name = ' + table_headers
	mark.execute(column_names)
	headers = mark.fetchall()

	i=0
	for col in headers:
		col = str(col)[2:-3]
		record.rename(columns={i:col}, inplace=True)
		i += 1

def rename_custom(custom_headers, df): # RENAME COLUMNS

	i=0
	for col in custom_headers:
		df.rename(columns={i:col}, inplace=True)
		i += 1

def vpip_pfr(number):

    mark = login(number)
    distinct = ''
    column = 'id_player, id_limit, cnt_vpip, cnt_hands, cnt_walks, cnt_pfr, cnt_pfr_opp, amt_expected_bb_won'
    table = 'cash_cache'
    
    custom_headers = ('PLAYER_ID', 'LIMIT', 'cnt_vpip', 'cnt_hands', 'cnt_walks', 'cnt_pfr', 'cnt_pfr_opp', 'amt_expected_bb_won')
    
    statement = 'SELECT ' + column + ' FROM ' + table
    
    mark.execute(statement)
    
    vpip = mark.fetchall()
    vpip = pd.DataFrame(vpip)
    rename_custom(custom_headers, vpip)
    
    ## LIMIT IDs
    statement = 'SELECT id_limit,amt_bb FROM cash_limit'
    
    mark.execute(statement)
    limits = mark.fetchall()
    limits = pd.DataFrame(limits)
    
    custom_headers = ('LIMIT','BB_SIZE')
    rename_custom(custom_headers, limits)
    
    limits.to_csv('limits.csv')
    
    ## PLAYER NAMES
    statement = 'SELECT id_player, player_name FROM player'
    mark.execute(statement)
    screennames = mark.fetchall()
    screennames = pd.DataFrame(screennames)
    
    custom_headers = ('PLAYER_ID', 'NAME')
    rename_custom(custom_headers, screennames)
    
    for i in range(len(screennames.NAME)):
        name = screennames.NAME.ix[i]
        name = unicode(name, errors = 'ignore')
        screennames.NAME.ix[i] = name
    
    screennames.to_csv('screennames.csv')
    
    
    screennames = screennames.set_index('PLAYER_ID')
    limits = limits.set_index('LIMIT')
    
    limits = limits[np.logical_or(limits.BB_SIZE == 1,limits.BB_SIZE == 2)]
    
    vpip = vpip.join(limits, on='LIMIT', how = 'left')
    del vpip['LIMIT']
    
    vpip = vpip[np.logical_or(vpip.BB_SIZE == 1, vpip.BB_SIZE == 2)]
    
    vpip = vpip.join(screennames, on = 'PLAYER_ID', how = 'left')
    vpip = vpip.set_index('NAME')
    del vpip['PLAYER_ID']
    del vpip['BB_SIZE']
    vpip.to_csv('3_VPIP_PFR' + str(number) + '.csv')

for i in range(1,5):
    vpip_pfr(i)
