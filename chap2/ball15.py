import sys
import pandas as pd

args = sys.argv
if len(args) == 2:
    df = pd.read_csv('../data/popular-names.txt', sep='\t', header=None)
    print(df.tail(int(args[1])))
else:
    print("f*ck off")
