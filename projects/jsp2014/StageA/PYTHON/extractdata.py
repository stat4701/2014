import pandas as pd
import numpy as np
from pandas import *
import os
import psycopg2
import sys

pd.set_option('max_rows',4000)
pd.set_option('max_columns',1000)
pandas.set_option('precision',3)
os.chdir('c:/users/jp/desktop/dropbox/school/spring2014/edav/Poker data/NEW_TRY/1_DATA')


def login(db):
	# the databases are EDAV_1,...,EDAV_4
	# connection = psycopg2.connect("dbname= " + db + " user=postgres password=postgrespass")
    db_name = db
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

################################################################################################
def create_hands(db): # creates a dataframe of all the individual hands in the databas
    mark = login(db) # log into this database

    column = 'id_player, amt_won, amt_expected_won, id_limit' # colums from the SQL database
    table = 'cash_hand_player_statistics' # tables from the SQL database

    custom_headers = ('PLAYER_ID', 'AMT_WON', 'EV_WON', 'LIMIT') # custom names for dataframe

    # SQL statement
    statement = 'SELECT id_player, amt_won, amt_expected_won, id_limit FROM cash_hand_player_statistics'

    ## exceute SQL statement and pull into dataframe
    mark.execute(statement)
    allh = mark.fetchall()
    allh = pd.DataFrame(allh)
    rename_custom(custom_headers, allh)

    return allh

def create_limits(db): # creates a dataframe of all the individual limits in the database
    mark = login(db) # log into this database

    statement = 'SELECT id_limit,amt_bb FROM cash_limit' #SQL statement

    ## execute SQL statement and pull into dataframe
    mark.execute(statement)
    lim = mark.fetchall()
    lim = pd.DataFrame(lim)
    custom_headers = ('LIMIT','BB_SIZE')
    rename_custom(custom_headers, lim)
    lim = lim.set_index('LIMIT')

    return lim

def create_screennames(db):# creates a dataframe of all the individual limits in the database
    mark = login(db) # log into this database

    statement = 'SELECT id_player, player_name FROM player' #SQL statement

    ## execute SQL statement and pull into dataframe
    mark.execute(statement)
    sn = mark.fetchall()
    sn = pd.DataFrame(sn)

    custom_headers = ('PLAYER_ID', 'NAME')
    rename_custom(custom_headers, sn)
    sn = sn.set_index('PLAYER_ID')

    return sn


databases =  ('EDAV_1', 'EDAV_2', 'EDAV_3', 'EDAV_4')
for db in databases:
    ## create the dataframes for the relational tables
    all_hands = create_hands(db)
    limits = create_limits(db)
    screennames = create_screennames(db)

    ## join the 3 dataframes into one, and keep only hands with $1 or $2 BB_SIZE
    all_hands = all_hands.join(limits, on='LIMIT', how = 'left')
    del all_hands['LIMIT']
    all_hands = all_hands[np.logical_or(all_hands.BB_SIZE == 1, all_hands.BB_SIZE == 2)]
    all_hands = all_hands.join(screennames, on = 'PLAYER_ID', how = 'left')
    del all_hands['PLAYER_ID']

    ## make the numbers floats so we can make calculations with them
    make_float = lambda x: float(x)
    all_hands.EV_WON = all_hands.EV_WON.apply(make_float)
    all_hands.AMT_WON = all_hands.AMT_WON.apply(make_float)
    all_hands.BB_SIZE = all_hands.BB_SIZE.apply(make_float)

    ## convert units from dollars to big blinds
    all_hands.AMT_WON = all_hands.AMT_WON / all_hands.BB_SIZE
    all_hands.EV_WON = all_hands.EV_WON / all_hands.BB_SIZE
    del all_hands['BB_SIZE']

    ## make a table of players by screenname
    hands = all_hands.NAME.value_counts()
    bb_won = all_hands.groupby('NAME').AMT_WON.sum()
    evbb_won = all_hands.groupby('NAME').EV_WON.sum()
    players = pd.concat((hands, bb_won, evbb_won), axis=1)
    players.columns = ('HANDS','AMT_WON','EV_WON')

    ## make number of hands played a float
    players.HANDS = players.HANDS.apply(make_float)

    ## fix the screennames
    players['nametemp'] = players.index
    fix_name = lambda x: unicode(x, errors = 'replace').replace(u"\ufffd",'*')
    players.nametemp = players.nametemp.apply(fix_name)

    print db + ' duplicates : '
    print players[players.duplicated('nametemp') == True]
    print ''

    players = players.set_index('nametemp')
    players.index.name = 'NAME'
    all_hands.index.name = 'HAND_ID'

    ## save the databases for manipulation later because all 4 won't fit into memory at once
    players.to_csv('1_EDAV_PLAYERS_' + str(db.split('_')[1]) + '.csv')
    all_hands.to_csv('1_EDAV_HANDS_' + str(db.split('_')[1]) + '.csv')


