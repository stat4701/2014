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

def create_buckets(all_hands, n, bucket_size):
	for i in all_hands.index:
		name = all_hands.NAME[i]
		if name in bucket:
			all_hands.BUCKET[i] = bucket[name][0]
			bucket[name][1] += 1
			if bucket[name][1] > bucket_size:
				bucket[name][0] += 1
				bucket[name][1] = 1
		else:
			bucket[name] = []
			bucket[name].append(1)
			bucket[name].append(2)
			all_hands.BUCKET[i] = bucket[name][0]

	all_hands.to_csv('8_BUCKETS_REGULARS_' + str(bucket_size) + '_' + str(n) + '.csv')

bucket = {} # contains lists of (bucket#,count)

df = read_csv('7_ALL_HANDS_1.csv', index_col = 'shuffle')
create_buckets(df, 1, 250)

df = read_csv('7_ALL_HANDS_2.csv', index_col = 'shuffle')
create_buckets(df, 2, 250)

df = read_csv('7_ALL_HANDS_3.csv', index_col = 'shuffle')
create_buckets(df, 3, 250)

df = read_csv('7_ALL_HANDS_4.csv', index_col = 'shuffle')
create_buckets(df, 4, 250)

df = read_csv('7_ALL_HANDS_5.csv', index_col = 'shuffle')
create_buckets(df, 5, 250)

df = read_csv('7_ALL_HANDS_6.csv', index_col = 'shuffle')
create_buckets(df, 6, 250)

df = read_csv('7_ALL_HANDS_7.csv', index_col = 'shuffle')
create_buckets(df, 7, 250)

df = read_csv('7_ALL_HANDS_8.csv', index_col = 'shuffle')
create_buckets(df, 8, 250)

df = read_csv('7_ALL_HANDS_9.csv', index_col = 'shuffle')
create_buckets(df, 9, 250)

df = read_csv('7_ALL_HANDS_10.csv', index_col = 'shuffle')
create_buckets(df, 10, 250)
