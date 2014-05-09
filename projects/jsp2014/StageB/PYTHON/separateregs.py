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

vpip_all = read_csv('3_VPIP_PFR1.csv')
vpip2 = read_csv('3_VPIP_PFR2.csv')
vpip3 = read_csv('3_VPIP_PFR3.csv')
vpip4 = read_csv('3_VPIP_PFR4.csv')

vpip_all = vpip_all.append(vpip2)
vpip_all = vpip_all.append(vpip3)
vpip_all = vpip_all.append(vpip4)

vpip_all = vpip_all.groupby('NAME').sum()
vpip_all = vpip_all.sort('cnt_hands', ascending = False)

for col in vpip_all.columns:
    vpip_all[col] = vpip_all[col].apply(lambda x: float(x))

vpip_all['VPIP'] = vpip_all.cnt_vpip / (vpip_all.cnt_hands - vpip_all.cnt_walks)*100
vpip_all['PFR'] = vpip_all.cnt_pfr / vpip_all.cnt_pfr_opp*100
vpip_all['EV_250'] = vpip_all.amt_expected_bb_won / vpip_all.cnt_hands * 250

for col in vpip_all.columns[:-3]:
    if col != 'cnt_hands':
        del vpip_all[col]

vpip_all = vpip_all[isnan(vpip_all.VPIP) == False]
vpip_all = vpip_all[isnan(vpip_all.PFR) == False]

vpip_all2 = vpip_all[vpip_all.cnt_hands >= 350]
vpip_all2.sort('cnt_hands').head(10)
vpip_cutoff = vpip_all2[vpip_all2.cnt_hands > 30000]
vpip_cutoff.VPIP = vpip_cutoff.VPIP/100

vpip_all = vpip_all[vpip_all.cnt_hands >= 350]
vpip_all['RAND'] = 0
vpip_all['RAND'] = vpip_all['RAND'].apply(lambda x: np.random.normal(0,1))
vpip_all = vpip_all.sort('RAND')

def gmm_df(vpip_all, n, cov):
    # shuffle the dataframe
    vpip_all['RAND'] = 0
    vpip_all['RAND'] = vpip_all['RAND'].apply(lambda x: np.random.normal(0,1))
    vpip_all = vpip_all.sort('RAND')

    x1 = vpip_all.VPIP.values
    x2 = vpip_all.PFR.values

    cutoff = int(np.ceil(len(x1)*0.75))

    vpip_all['SET'] = ''
    j = 0
    for i in vpip_all.index:
        if j < cutoff:
            vpip_all.SET.ix[i] = 'Training'
        else:
            vpip_all.SET.ix[i] = 'Test'
        j += 1

    X_train = np.c_[x1[:cutoff],x2[:cutoff]]
    X_test = np.c_[x1[cutoff:],x2[cutoff:]]


    clf = mixture.GMM(n_components=n, covariance_type=cov)
    clf.fit(X_train)

    train_predict = clf.predict(X_train)
    test_predict = clf.predict(X_test)

    X_train = np.c_[X_train,train_predict]
    X_test = np.c_[X_test,test_predict]


    all_predictions = np.r_[X_train,X_test]

    vpip_all['Class'] = ''

    labels = all_predictions[:,2]
    j = 0
    for i in vpip_all.index:
        vpip_all.Class.ix[i] = labels[j]
        j += 1

    del vpip_all['RAND']
    return vpip_all

    
def gmm_plot(vpip_all, n, cov, set_type, sub, titlefont, slim = True):
    
    train = vpip_all[vpip_all.SET == 'Training']
    test = vpip_all[vpip_all.SET == 'Test']

    winrates = {}
    for i in range(n):
        if set_type == 'Training':
            class_type = train[train.Class == i]
        elif set_type == 'Test':
            class_type = test[test.Class == i]
        else:
            class_type = vpip_all[vpip_all.Class == i]
            
        class_type['TOT_EV'] = class_type.EV_250*class_type.cnt_hands/250
        win = class_type.TOT_EV.sum() / class_type.cnt_hands.sum()*250
        winrates[i] = win
        
    return winrates
    

cov = 'full'
set_type = 'Full'
n = 8
vpip_gmm = gmm_df(vpip_all,n, cov)
winrates = gmm_plot(vpip_gmm, n, cov, set_type, (1,1,1), 16, False)

keep = []
for i in winrates:
    if winrates[i] > -25:
        keep.append(i)
        
vpip_gmm_reduced = vpip_gmm.copy()
vpip_gmm_reduced['KEEP'] = ''
vpip_gmm_reduced.KEEP = vpip_gmm_reduced.Class.apply(lambda x: 'yes' 
                                                     if x in keep 
                                                     else 'no')
vpip_gmm_reduced = vpip_gmm_reduced[vpip_gmm_reduced.KEEP == 'yes']
del vpip_gmm_reduced['KEEP']

cov = 'full'
set_type = 'Test'
n = 2

vpip_gmm = gmm_df(vpip_gmm_reduced,n, cov)
winrates = gmm_plot(vpip_gmm, n, cov, set_type, (1,1,1), 16)

keep = []
for i in winrates:
    if winrates[i] > -10:
        keep.append(i)
        
vpip_gmm_reduced = vpip_gmm.copy()
vpip_gmm_reduced['KEEP'] = ''
vpip_gmm_reduced.KEEP = vpip_gmm_reduced.Class.apply(lambda x: 'yes' 
                                                     if x in keep 
                                                     else 'no')

vpip_gmm_reduced = vpip_gmm_reduced[vpip_gmm_reduced.KEEP == 'yes']

del vpip_gmm_reduced['KEEP']

regulars_gmm = vpip_gmm.index.values

scatters = vpip_all2[vpip_all2.cnt_hands > 350]

scatters['EV_TOTAL'] = scatters.cnt_hands*scatters.EV_250/250



def cluster_plot_single(scatters, clusters):
    np.random.seed(5)
    
    centers = [[1, 1], [-1, -1], [1, -1]]
    
    X = scatters[['VPIP','PFR']]
    
    est = KMeans(n_clusters=clusters)
    est.fit(X)
    labels = est.labels_
    
    labels = pd.Series(labels, index = X.index, name = 'LABEL')
    
    X = X.join(labels, how = 'left')
    X = X.join(scatters.EV_TOTAL, how = 'left')
    X = X.join(scatters.cnt_hands, how = 'left')
    

    
    winrates = {}
    for i in range(clusters):
        win = (X[X.LABEL == i].EV_TOTAL.sum() / X[X.LABEL == i].cnt_hands.sum()*250)
        winrates[i] = win
            
    return X, winrates

X,winrates = cluster_plot_single(scatters, 8)

keep = []
for i in winrates:
    if winrates[i] > -10:
        keep.append(i)
        
X['KEEP'] = X.LABEL.apply(lambda x: True if x in keep else False)
cluster1 = X[X.KEEP == True].index.values


plt.clf()
X, winrates = cluster_plot_single(scatters[scatters.cnt_hands > 5000], 4)

keep = []
for i in winrates:
    if winrates[i] > -10:
        keep.append(i)

X['KEEP'] = X.LABEL.apply(lambda x: True if x in keep else False)
cluster2 = X[X.KEEP == True].index.values

regulars = scatters.copy()
regulars['REGULAR'] = ''
regulars['temp'] = regulars.index

def reg_test(x):
    if regulars.cnt_hands.ix[x] > 5000:
        if x in cluster2:
            return True
        else:
            return False
    else:
        if x in cluster1:
            return True
        else:
            return False

regulars.REGULAR = regulars.temp.apply(reg_test)
del regulars['temp']

regulars_only = regulars[regulars.REGULAR == True] 


# We eliminated nearly half the players with k-means and those players had a massive losing rate overall (not weighted by number of hands, which makes it look less effective). We can also see that we eliminated players with many fewer hands on average, which is a great side effect, since these players are the types who are prone to being misclassified. This is because there are so many of these types, and so it's likely there are several outliers who would slip through the cracks.
regulars['GMM_REG'] = ''
regulars['tempname'] = regulars.index
regulars.GMM_REG = regulars.tempname.apply(lambda x: True if x in regulars_gmm else False)
del regulars['tempname']

regulars['TOTAL_REG'] = np.logical_and(regulars.REGULAR == True, regulars.GMM_REG == True)
all_regs = regulars[regulars.TOTAL_REG == True]
all_recreation = regulars[regulars.TOTAL_REG == False]

all_regs.to_csv('4_ALL_REGS.csv')
all_recreation.to_csv('4_ALL_RECREATIONAL.csv')