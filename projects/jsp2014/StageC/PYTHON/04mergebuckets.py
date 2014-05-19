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
from matplotlib.ticker import NullFormatter
from sklearn.neighbors.kde import KernelDensity


pd.set_option('max_rows',4000)
pd.set_option('max_columns',1000)
pandas.set_option('precision',3)
os.chdir('c:/users/jp/desktop/dropbox/school/spring2014/edav/Poker data/NEW_TRY/StageC')


def sum_buckets(bucket, n):
    bucket['HANDS'] = 1
    bucket.sort('BUCKET', inplace = True)
    bucket.sort('NAME', inplace = True)
    bucket = bucket.groupby(('NAME','BUCKET')).sum()
    return bucket

bucket1 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_1.csv', index_col = 'shuffle'),1)
bucket2 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_2.csv', index_col = 'shuffle'),2)
bucket3 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_3.csv', index_col = 'shuffle'),3)
bucket4 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_4.csv', index_col = 'shuffle'),4)
bucket5 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_5.csv', index_col = 'shuffle'),5)
bucket6 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_6.csv', index_col = 'shuffle'),6)
bucket7 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_7.csv', index_col = 'shuffle'),7)
bucket8 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_8.csv', index_col = 'shuffle'),8)
bucket9 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_9.csv', index_col = 'shuffle'),9)
bucket10 = sum_buckets(read_csv('8_BUCKETS_REGULARS_250_10.csv', index_col = 'shuffle'),10)

bucket_all = bucket1.append(bucket2)
bucket_all = bucket_all.append(bucket3)
bucket_all = bucket_all.append(bucket4)
bucket_all = bucket_all.append(bucket5)
bucket_all = bucket_all.append(bucket6)
bucket_all = bucket_all.append(bucket7)
bucket_all = bucket_all.append(bucket8)
bucket_all = bucket_all.append(bucket9)
bucket_all = bucket_all.append(bucket10)

bucket_all.to_csv('9_BUCKETS_ALL.csv')

bucket_all2 = read_csv('9_BUCKETS_ALL.csv')
bucket_all2 = bucket_all2.groupby(('NAME','BUCKET')).sum()

bucket_all2 = bucket_all2.reset_index()
bucket_all2.sort('BUCKET',ascending = False,inplace = True)
bucket_all2.head()

bucket_all2 = bucket_all2[bucket_all2.HANDS > 249]

mean = bucket_all2.groupby('NAME').mean()
bucket_all2['BUCKETS'] = 1

sums = bucket_all2.groupby('NAME').sum()
stdev = bucket_all2.groupby('NAME').std()

all_players = mean.copy()
all_players = all_players.join(sums, rsuffix = '_SUM')
all_players = all_players.join(stdev, rsuffix = '_STD')

all_players = all_players[['HANDS_SUM','EV_WON','EV_WON_STD']]
all_players.columns = 'HANDS','EV_250','EV_250_STD'
all_players = all_players[isnan(all_players.EV_250_STD) == False]
all_players.sort('HANDS',ascending = False, inplace = True)

all_players.to_csv('10_ALL_PLAYERS.csv')
