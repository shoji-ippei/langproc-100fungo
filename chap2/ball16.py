import sys
import pandas as pd

args = sys.argv
if len(args) == 2:
    df = pd.read_csv('../data/popular-names.txt', sep='\t', header=None)
    n=int(args[1])
    dfs = [df.loc[i:i+n-1, :] for i in range(0, df.shape[0], n)]
    print(dfs)
else:
    print("f*ck off")
