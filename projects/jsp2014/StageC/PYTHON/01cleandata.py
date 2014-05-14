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


hands1 = read_csv('1_EDAV_HANDS_1.csv')
hands2 = read_csv('1_EDAV_HANDS_2.csv')
hands3 = read_csv('1_EDAV_HANDS_3.csv')
hands4 = read_csv('1_EDAV_HANDS_4.csv')

for db in (hands1, hands2, hands3, hands4):
    # is this player in the list of regulars?
    db['REG'] = db.NAME.apply(lambda x: True if x in regulars_list else False)

def all_regs(db):
    # is this player in the list of regulars?
    db = db[db.REG == True]
    del db['REG']
    # set index to name
    db = db.set_index('NAME')
    return db

hands1 = all_regs(hands1)
hands2 = all_regs(hands2)
hands3 = all_regs(hands3)
hands4 = all_regs(hands4)

del hands1['HAND_ID']
del hands2['HAND_ID']
del hands3['HAND_ID']
del hands4['HAND_ID']

all_hands = hands1.append(hands2)
all_hands = all_hands.append(hands3)
all_hands = all_hands.append(hands4)
all_hands.to_csv('5_ALL_HANDS.csv')


df = read_csv('4_ALL_REGS.csv', index_col = 'NAME')
regulars_list = df.index.values


def clean_hands(num):
	db = read_csv('1_EDAV_HANDS_' + str(num) + '.csv')

	# is this player in the list of regulars?
	db['REG'] = db.NAME.apply(lambda x: True if x in regulars_list else False)
	db = db[db.REG == True]
	del db['REG']
	# set index to name
	db = db.set_index('NAME')
	return db

	del db['HAND_ID']

	db.to_csv('5_ALL_HANDS_' + str(num) + '.csv')

for i in range(1,5):
	clean_hands(i)