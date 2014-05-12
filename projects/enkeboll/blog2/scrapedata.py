''' Notes
 - main article: http://fivethirtyeight.com/datalab/some-data-for-equal-pay-day/
 - firstdata: http://www.nwlc.org/sites/default/files/pdfs/nov2013_state_by_state_women_overall.pdf
  - 2nddata: http://www.bls.gov/cps/cpswom2012.pdf

'''

import pandas as pd


def main():
    # load wage data, copied and pasted into CSV from
    # http://www.nwlc.org/sites/default/files/pdfs/nov2013_state_by_state_women_overall.pdf
    wage_df = pd.read_csv('state_earnings.csv', index_col=1)

    # load standard of living data programmatically
    url = "http://www.missourieconomy.org/indicators/cost_of_living/index.stm"
    sol_df = pd.read_html(url, flavor='bs4', header=1, skiprows=[0,53], attrs={'class': 'excel24'})[0]
    sol_df.rename(columns={'Rank': 'PopRank'}, inplace=True)

    # load id to abbreviation table so that we can put info on a topojson map
    id_df = pd.read_csv('us-state-names.tsv', sep='\t')

    # combine id_df and sol_df on names
    sol_df = pd.merge(id_df, sol_df, left_on="name", right_on="State")
    sol_df = sol_df.drop('name', 1).rename(columns={'code': 'Abbrev'}).set_index('Abbrev')

    # combine data frames on state names
    state_df = sol_df.join(wage_df)

    # output data frame in d3-friendly json
    state_df.to_csv('states_final.tsv', sep='\t')

if __name__ == '__main__':
    main()