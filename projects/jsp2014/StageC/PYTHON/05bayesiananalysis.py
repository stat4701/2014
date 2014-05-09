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





params = stats.invgamma.fit(all_players[all_players.HANDS>2500].EV_250_STD.values)


alpha = params[0]
beta = params[2]
bias = params[1]

nu_0 = 2*alpha

df_conjugate = all_players[all_players.HANDS>2500]

# weighted mean and stdev
df_conjugate['TOT_EV'] = df_conjugate.HANDS*df_conjugate.EV_250/250 
df_conjugate['WEIGHT'] = df_conjugate.HANDS/df_conjugate.HANDS.sum()

mu_0 = df_conjugate.TOT_EV.sum() / df_conjugate.HANDS.sum() * 250

df_conjugate['WGT_SQR_ERR'] = (df_conjugate.EV_250 - mu_0)**2*df_conjugate.WEIGHT
sigma2_0 = df_conjugate.WGT_SQR_ERR.sum()

kappa_0 = len(df_conjugate)

print 'kappa_0: ' + str('%.3f' % kappa_0)
print 'mu_0: ' + str('%.3f' % mu_0)
print 'sigma2_0: ' + str('%.3f' % sigma2_0)

df_conjugate['n'] = df_conjugate.HANDS / 250

def kappa_p(kappa,n):
    return kappa+n

def mu_p(kappa,n,mu,ybar):
    return kappa*mu/kappa_p(kappa,n) + n*ybar/kappa_p(kappa,n)

def nu_p(nu,n):
    return nu+n

def sigma2_p(nu,sigma2,n,s,kappa,ybar,mu):
    part1 = nu*sigma2
    part2 = (n-1)*s**2
    part3 = (kappa*n)/(kappa+n)*(ybar - mu)**2
    return (part1 + part2 + part3) / nu_p(nu,n)

s = df_conjugate.EV_250_STD.ix[0]
ybar = df_conjugate.EV_250.ix[0]
n = df_conjugate.n.ix[0]

mu_n = mu_p(kappa_0,n,mu_0,ybar)
kappa_n = kappa_p(kappa_0,n)
nu_n = nu_p(nu_0,n)
sigma2_n = sigma2_p(nu_0,sigma2_0,n,s,kappa_0,ybar,mu_0)

df_conjugate['kappa_p'] = kappa_0 + df_conjugate.n
df_conjugate['nu_p'] = nu_0 + df_conjugate.n
df_conjugate['mu_p'] = kappa_0*mu_0/df_conjugate.kappa_p + df_conjugate.n*df_conjugate.EV_250/df_conjugate.kappa_p
df_conjugate['sigma2_p'] = ((nu_0*sigma2_0)+((df_conjugate.n-1)*df_conjugate.EV_250_STD**2)+
                            ((kappa_0*df_conjugate.n)/(kappa_0+df_conjugate.n)*
                             (df_conjugate.EV_250 - mu_0)**2))/(df_conjugate.nu_p)
df_conjugate['post_std'] = df_conjugate.sigma2_p/df_conjugate.kappa_p

df_conjugate = df_conjugate[['HANDS','EV_250','EV_250_STD','mu_p','post_std']]
df_conjugate.columns = 'HANDS','EV_250','EV_250_STD','EV_250_POST','EV_250_STD_POST'

df_conjugate = df_conjugate.sort('EV_250_POST',ascending = False)

df_conjugate.to_csv('10_ALL_PLAYERS.csv')