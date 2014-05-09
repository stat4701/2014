import pandas as pd
import numpy as np
from pandas import *
import os
import psycopg2
import sys
import brewer2mpl
import pylab as P
import matplotlib as plt
import matplotlib
import matplotlib.pyplot as plt
import scipy as sc
from scipy import stats
from scipy.stats import norm
from pylab import *
from numpy import float64

pd.set_option('max_rows',4000)
pd.set_option('max_columns',1000)
pandas.set_option('precision',3)
os.chdir('C:\Users\JP\Desktop\Dropbox\SCHOOL\Spring2014\EDAV\Poker data\NEW_TRY\StageA')


players1 = read_csv('DATA/1_EDAV_PLAYERS_1.csv', index_col = 'NAME')
players2 = read_csv('DATA/1_EDAV_PLAYERS_2.csv', index_col = 'NAME')
players3 = read_csv('DATA/1_EDAV_PLAYERS_3.csv', index_col = 'NAME')
players4 = read_csv('DATA/1_EDAV_PLAYERS_4.csv', index_col = 'NAME')

i = 1
for df in (players1, players2, players3, players4):
    col_names = []
    for col in df.columns:
        col_names.append(col + '_' + str(i))
    df.columns = col_names
    i += 1
    
all_players = players1.join(players2, how = 'outer')
all_players = all_players.join(players3, how = 'outer')
all_players = all_players.join(players4, how = 'outer')

null_zero = lambda x: 0 if isnan(x) else x
old_cols = all_players.columns
for col in old_cols:
	all_players[col] = all_players[col].apply(null_zero)

all_players.head()

all_players['HANDS'] = all_players.HANDS_1 + all_players.HANDS_2 + all_players.HANDS_3 + all_players.HANDS_4
all_players['AMT_WON'] = all_players.AMT_WON_1 + all_players.AMT_WON_2 + all_players.AMT_WON_3 + all_players.AMT_WON_4
all_players['EV_WON'] = all_players.EV_WON_1 + all_players.EV_WON_2 + all_players.EV_WON_3 + all_players.EV_WON_4

for col in old_cols:
	del all_players[col]

all_players = all_players.sort('HANDS', ascending = False)

allplayers.to_csv('DATA/2_ALL_PLAYERS.csv')