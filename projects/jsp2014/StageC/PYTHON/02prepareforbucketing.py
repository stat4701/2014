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


## STEP 1 - shuffle index and join as column
df = read_csv('5_ALL_HANDS.csv')
del df['AMT_WON']
shuffle_vals = df.index.values
np.random.shuffle(shuffle_vals)

shuffle = Series(shuffle_vals, index = range(len(df)))
shuffle.name = 'shuffle'

df = df.join(shuffle, how = 'left')
df.to_csv('6_SHUFFLE_STEP1.csv')
## STEP 2 - sort
df = read_csv('6_SHUFFLE_STEP1.csv', index_col = 'shuffle')
del df['Unnamed: 0']

df.sort_index(inplace = True)
df.to_csv('6_SHUFFLE_STEP2.csv')
## STEP 3 - break into chunks
df = read_csv('6_SHUFFLE_STEP2.csv', index_col = 'shuffle')
piece = np.floor(len(df)/10)

x1 = int(piece)
x2 = int(piece*2)
x3 = int(piece*3)
x4 = int(piece*4)
x5 = int(piece*5)
x6 = int(piece*6)
x7 = int(piece*7)
x8 = int(piece*8)
x9 = int(piece*9)

df['BUCKET'] = ''
df.ix[0:x1].to_csv('7_ALL_HANDS_1.csv')
df.ix[x1:x2].to_csv('7_ALL_HANDS_2.csv')
df.ix[x2:x3].to_csv('7_ALL_HANDS_3.csv')
df.ix[x3:x4].to_csv('7_ALL_HANDS_4.csv')
df.ix[x4:x5].to_csv('7_ALL_HANDS_5.csv')
df.ix[x5:x6].to_csv('7_ALL_HANDS_6.csv')
df.ix[x6:x7].to_csv('7_ALL_HANDS_7.csv')
df.ix[x7:x8].to_csv('7_ALL_HANDS_8.csv')
df.ix[x8:x9].to_csv('7_ALL_HANDS_9.csv')
df.ix[x9:len(df)-1].to_csv('7_ALL_HANDS_10.csv')
