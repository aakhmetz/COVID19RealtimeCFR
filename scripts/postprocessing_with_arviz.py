import sys

import pandas as pd
import numpy as np
import scipy as sp
import scipy.stats as ss
import arviz as az

from subprocess import Popen, PIPE

import glob

# glob string
posterior_glob = glob.glob(sys.argv[1]+'/trace-[0-9]*')

cmdstan_data = az.from_cmdstan(posterior = posterior_glob)

func_dict = {"q2.5": lambda x: np.percentile(x, 2.5), 
             "q25": lambda x: np.percentile(x, 25), 
             "median": lambda x: np.percentile(x, 50), 
             "q75": lambda x: np.percentile(x, 75), 
             "q97.5": lambda x: np.percentile(x, 97.5)}

# include mean and hpd
stats = az.summary(cmdstan_data,credible_interval=0.95).loc[:, ['mean','hpd_2.5%','hpd_97.5%','ess_bulk','ess_tail','r_hat']].reset_index().rename(columns={'index':'var', 'hpd_2.5%':'hpd2.5', 'hpd_97.5%':'hpd97.5'})
stats = az.summary(cmdstan_data,credible_interval=0.50).loc[:, ['hpd_25%','hpd_75%']].reset_index().rename(columns={'index':'var', 'hpd_25%':'hpd25', 'hpd_75%':'hpd75'}).\
    merge(stats, left_on='var', right_on='var')
# include percentiles
stats = az.summary(cmdstan_data, stat_funcs=func_dict, extend=False).reset_index().rename(columns={'index': 'var'}).merge(stats, left_on='var', right_on='var')
stats['time'] = stats['var'].apply(lambda st: st[st.find("[")+1:st.find("]")])
stats['time'] = ['NA' if "[" not in y else int(x)+1 for x,y in zip(stats['time'],stats['var'])]
stats['var'] = stats['var'].apply(lambda st: st[:st.find("[")] if "[" in st else st)
stats.loc[:,['var','time','mean','hpd2.5','hpd25','hpd75','hpd97.5','q2.5','q25','median','q75','q97.5','ess_bulk','ess_tail','r_hat']].to_csv(sys.argv[1]+'/'+sys.argv[2], index=False)

print('Done: see '+sys.argv[1]+'/'+sys.argv[2])